/*
  # Create Storage Buckets

  ## Overview
  Creates storage buckets for:
  - Product images
  - Banners
  - Categories
  - User avatars
  - Try-on uploads

  ## Security
  - Public read access for product images, banners, and categories
  - Authenticated users can upload avatars and try-on images
*/

-- Create storage buckets
INSERT INTO storage.buckets (id, name, public)
VALUES 
  ('product-images', 'product-images', true),
  ('banners', 'banners', true),
  ('categories', 'categories', true),
  ('avatars', 'avatars', true),
  ('tryon-uploads', 'tryon-uploads', false)
ON CONFLICT (id) DO NOTHING;

-- Storage policies for product-images bucket
CREATE POLICY "Anyone can view product images"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'product-images');

CREATE POLICY "Authenticated users can upload product images"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'product-images');

CREATE POLICY "Authenticated users can update product images"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (bucket_id = 'product-images');

CREATE POLICY "Authenticated users can delete product images"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (bucket_id = 'product-images');

-- Storage policies for banners bucket
CREATE POLICY "Anyone can view banners"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'banners');

CREATE POLICY "Authenticated users can upload banners"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'banners');

CREATE POLICY "Authenticated users can update banners"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (bucket_id = 'banners');

CREATE POLICY "Authenticated users can delete banners"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (bucket_id = 'banners');

-- Storage policies for categories bucket
CREATE POLICY "Anyone can view category images"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'categories');

CREATE POLICY "Authenticated users can upload category images"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'categories');

CREATE POLICY "Authenticated users can update category images"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (bucket_id = 'categories');

CREATE POLICY "Authenticated users can delete category images"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (bucket_id = 'categories');

-- Storage policies for avatars bucket
CREATE POLICY "Anyone can view avatars"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'avatars');

CREATE POLICY "Authenticated users can upload own avatar"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);

CREATE POLICY "Authenticated users can update own avatar"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);

CREATE POLICY "Authenticated users can delete own avatar"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);

-- Storage policies for tryon-uploads bucket
CREATE POLICY "Users can view own tryon uploads"
  ON storage.objects FOR SELECT
  TO authenticated
  USING (bucket_id = 'tryon-uploads' AND (storage.foldername(name))[1] = auth.uid()::text);

CREATE POLICY "Authenticated users can upload tryon images"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'tryon-uploads');

CREATE POLICY "Authenticated users can delete own tryon images"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (bucket_id = 'tryon-uploads' AND (storage.foldername(name))[1] = auth.uid()::text);