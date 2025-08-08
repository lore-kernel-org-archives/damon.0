Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F54C1A2872
	for <damon@lists.linux.dev>; Fri,  8 Aug 2025 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682960; cv=none; b=oJPkV7ZQqfoUW6PexmK2mQZ+C80O9lfVmCZCxPV7NZ5IkR8ZgC9VGY8JoMtrp+LYej29J3XJNOaMsr8ia9LjJAqPk9DYA2rMu17QqkMNXJzbud2uyNia1OqeekEkOVpn86mr94bAKwyplq3IBuAzRY6zwGqIeq8XXYb0h92x+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682960; c=relaxed/simple;
	bh=vqR4ln1qnzCGIQ5P0Xlz2BMTGpCZEhHozmVQei9PqQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWZUHeWGskP224Q0VXKrKE7p6wgJd0yJ5L/QUeGz5DbLH5ZJYTO0HmooXi+UfON+oEaHCDD4wBV1I+IsFRovXKLobULYbIuWrhd231LcWDvylWCEnzAOkbdhZZYQOs1cHJYDC8r16UNtaxNFrZGrHYireeLd81Httf94cwhpfx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pk6xQ24F; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk6xQ24F"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76b77a97a04so2485191b3a.1
        for <damon@lists.linux.dev>; Fri, 08 Aug 2025 12:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754682958; x=1755287758; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J4Fi2mKTN/GdQ1NmR4jCj2VsL5TUv9pVfPKW/me6N0=;
        b=Pk6xQ24FoVXF+P22/8fq2doAxTWdi5NoBWYiux4j/6d90B/prsZU/qhd/pSYRz2xhM
         B/GmoQ/qOUdOEYBKKVX3/FnHXZ5Gd0PStPOf5mSf5Tg/bIJSSgsBUdZu4uFPuTzQZ4Ku
         uJ01CznqM8sFTZBdXgXC6F3M/Qw3W2idL9GiXKnjbk7Nk+j6SSlc3acnGTBBXSGBHv41
         JKIDAODa+7GGYYKM5N1KVz9Wi5djuaZCPj3QyP2Kl/z44pkq4X/6v0HdWWR3rJ5BnIAt
         hY/uBoLvrZ5pxBIY+jM5WQfwXSiVZmrlnrb8hc8XYwv37XLQVYllSND9USL0Tevh9lnY
         AOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682958; x=1755287758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J4Fi2mKTN/GdQ1NmR4jCj2VsL5TUv9pVfPKW/me6N0=;
        b=t6ibesw+xoKUrzsKfX/rcGzbYLH+QpUqCZu2vUgA6A1ONNoNWJK94YofUG/YnrpQX0
         oGo3SfFg5xrrYe7buOjLaNHuDk2MMRAYPkadhWHA6sWmYm9r0OCwlsDMfvuKiH6oGZd3
         k7cgTKn63D8f8XRNt/QABOXrZ6iwU1PiiXr0J/6cBe0xBwAOcgnqML3O8ih1hcca2nO/
         2ZKyvdzEwyK4uyHS/I2MktEY8Xw8E+8yqm9rWbvpL3F6rqD4h4pleR3UpEXEX2xTUr87
         u6dtepatH10dSwlJjXS1K5ZDAhROkdeNKTSBExzPeJgEuF5RX5r33WetmcP7benwVHNx
         mA3w==
X-Gm-Message-State: AOJu0YwHy19iKPWAKPSLe2x5yxS7EfXNGQQoj/RrsQUHA5PaswiOazcS
	ebVYNed0J6OvWWGWX2P+MfBG1tZMHeHg0RiC6ibQNmwPQxxG2opJfW0Z
X-Gm-Gg: ASbGncsQCqOWViHNhwLDtKKXA86l+jsJD9PsoybL2T+N+GXmlQ7Q70kF//yI3ZhutXC
	LJG8lpQ+wJtpLIt4ePStDcoKwGtu1IvOmfmVszATJaooPDOQYxuayeYrykSprpNScbfAmDszI9Y
	rXVoNYXz1Ie0K8xv9Ph7KzqY30I0Jajbi7OvmXkrJhs73AF1g9vQhLykAslID6sJlXiavOMQ9my
	++/2QMWOaxacdRMFKWn7guOQNBn5/S5qSEMrTzn0oI5WjPxPXPMBjlpAlgrTT0YfVUO0hG62EDX
	YB/ho7Zl7/exr5Gt6L+rHHNbb8ureGJAgFBpFNne+DgOuGg/EXlqvJf2adF7gt3uihT1Dr4ZUy3
	7wUEnGzGEhOxnzYhb
X-Google-Smtp-Source: AGHT+IHFbZ9g9txwoRArdrZPIHCxEoHurNyfEasCmGgGMvZpszV21DG4t4TeI/5uWuzfctJ73RcMdA==
X-Received: by 2002:a05:6a00:3d4e:b0:76b:f24d:6d67 with SMTP id d2e1a72fcca58-76c46193b4fmr6631578b3a.13.1754682958415;
        Fri, 08 Aug 2025 12:55:58 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f911sm21201103b3a.47.2025.08.08.12.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:55:58 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH 2/2] mm/damon/core : fix commit_ops_filters by using correct nth function
Date: Sat,  9 Aug 2025 04:55:18 +0900
Message-ID: <20250808195518.563053-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808195518.563053-1-ekffu200098@gmail.com>
References: <20250808195518.563053-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
iterates core_filters. As a result, performing a commit unintentionally
corrupts ops_filters.

Add damos_nth_ops_filter() which iterates ops_filters. Use this function
to fix issues caused by wrong iteration.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 mm/damon/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 883d791a10e5..19c8f01fc81a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -862,6 +862,18 @@ static struct damos_filter *damos_nth_filter(int n, struct damos *s)
 	return NULL;
 }
 
+static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
+{
+	struct damos_filter *filter;
+	int i = 0;
+
+	damos_for_each_ops_filter(filter, s) {
+		if (i++ == n)
+			return filter;
+	}
+	return NULL;
+}
+
 static void damos_commit_filter_arg(
 		struct damos_filter *dst, struct damos_filter *src)
 {
@@ -925,7 +937,7 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 	int i = 0, j = 0;
 
 	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
-		src_filter = damos_nth_filter(i++, src);
+		src_filter = damos_nth_ops_filter(i++, src);
 		if (src_filter)
 			damos_commit_filter(dst_filter, src_filter);
 		else
-- 
2.43.0

