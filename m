Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822B204873
	for <damon@lists.linux.dev>; Tue, 11 Feb 2025 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277892; cv=none; b=P4TbqccMvO9NBZSOY7vmx3bt0SzftAKMbNvguKBXEn0ULnNkW43xlKt+awgSldTwJu/VV66AtWV9t1MTlD2LJwHK9zaSt6YXAZavTMxN3bBo3kl9r2jyEwGGGk2cR2bDbRrWXAPuIdhFpdDcVBHgPXzP11T36Tu3cU2erNQ1V84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277892; c=relaxed/simple;
	bh=O7W8fpfea3D3BXvUVE0b/Wxaz51U4CeToGhLdxqG7X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3UsI7tQ7sbg8ySk5EyG8XEZsr7EqU9zERp+nZpn3FHbgn5dEyBHEepIe57OrmB74SqJvyGsPiANGSNN/A0bAAy/RNxiBo26Eii5X+UiNHxAaR1N5XtLCGw7s+a0YKJAIOhWJJHaIvQXCYxNNuBzJmH5bXeekphqaIaAoPMyWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHwsaA4+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHwsaA4+"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0545a1449so252525185a.1
        for <damon@lists.linux.dev>; Tue, 11 Feb 2025 04:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739277890; x=1739882690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aszcwZX/dL1jJJGnQ9D6oqqNkl8IH1IE/D7YPgpaGec=;
        b=FHwsaA4+JmvHzcn5e1PXVUhCeBpWXbbtore5Z8AQHsNmynRg8ixbOMJgXOhyn3eMgH
         KkDOnzCIOIm5FOw20vE8hYM8hU+WObx8NHYYUhTm4DcKF2r5eYwRmhSYU0RMmZMiaDQG
         M+NIyYQy7QFxxmLSe3NoIs/CqcivGvxnln/dPfYfAoFWRnbpcaqw1MtIv+4zoZHdSoq8
         H844DXz12gdPnw3q1oqykNSpTNTK5c0uB6TMMu8HdLxws5PxE03+NT4tH02oWcsultz3
         9IVcWSZ9R31Y6aLq8V2sVvz0NcP5AjMP39M+A1rtAdWIQUs1VkX4o2+EDh9cITlgKBvL
         3HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739277890; x=1739882690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aszcwZX/dL1jJJGnQ9D6oqqNkl8IH1IE/D7YPgpaGec=;
        b=fVNVY3MveTcm/t9srzyWQZSQXbLXDSpsGWEN+TzpDlRaVFARATt9e1eMz0eBjy5UnE
         i0p8u2r2B8OQbjRak8Xgq52+07fE/Uo3hymJZwYxUmta3PW72Q6MxPMI1QOS6mFwpZJA
         gHfzSlMl9NfjKO42KSzjQYs+sMm++GXl6kcNEFlEGVA8vhw3LSL4oSHQeikzelOyxwll
         9OL45nbwhtVXFE7T+ZNH91bXD+ynxdwiU0d99RARw3+ITDRgPS5fhdsXGteto3aJ1kX4
         Z4deBwo3LgXqQtvU3P/b/lcT9uH7VJ+lRfB20ppig89x7CvYfxKZkv26eBT2AqQVsuPe
         63MQ==
X-Gm-Message-State: AOJu0Yw+ZVnUqAyZWiKJWd+RY2zmjxzxl/Kgj4BwB0j//gCJxF4VHpcO
	maEgOOu0Y2dfu4FRx1TSACRKScdBgOcZPOEOfyMHUSTBSL08uEh0
X-Gm-Gg: ASbGncv0vMD0OQRVVecTDjsT3LvOyiOct0yCktDhv9FvbW/Y1lvodgIpByPuLGziBcc
	L2SfqbAGgQ5+oWjsHHBZIMC+gGQOxZb+ZVBc6ogjJKG0+w2nvJUmKEfqg0KCjZClhzIyaGR50C4
	whmU1mcnhfVUxo9NWL14k3hWT9ugwW7ybyxJIR6YuRlwkXGZT5USk/foP7ZhGQurH6SiSxsjCip
	OIrwyQ0qTgpL0fXRiYhoyXgELDtX3/c//vD2+xhd+DTVYtCqZHnrtMJVr0UKdABkHPFBQNFsVCB
	CzRx20N7hMFxBA==
X-Google-Smtp-Source: AGHT+IGHKdbhye6mWgXhoGfhTRR5ceGO4PfzUuR2tFrr/uG9wzr33+3V3hfqq0H4w3OojPxi/Fy6lg==
X-Received: by 2002:a05:620a:3908:b0:7b6:eba3:2dfa with SMTP id af79cd13be357-7c0690e39b7mr289317785a.22.1739277889625;
        Tue, 11 Feb 2025 04:44:49 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:73::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c065424c9esm173266585a.43.2025.02.11.04.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:44:49 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 3/4] Docs/ABI/damon: document DAMOS sysfs files to set the min/max folio_size
Date: Tue, 11 Feb 2025 12:43:42 +0000
Message-ID: <20250211124437.278873-4-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250211124437.278873-1-usamaarif642@gmail.com>
References: <20250211124437.278873-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used to decide the min and max folio size to operate on
for pa_stat.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index b057eddefbfc..ccd13ca668c8 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -345,6 +345,20 @@ Description:	If 'addr' is written to the 'type' file, writing to or reading
 		from this file sets or gets the end address of the address
 		range for the filter.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/min
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'hugepage_size' is written to the 'type' file, writing to
+		or reading from this file sets or gets the minimum size of the
+		hugepage for the filter.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/max
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'hugepage_size' is written to the 'type' file, writing to
+		or reading from this file sets or gets the maximum size of the
+		hugepage for the filter.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/target_idx
 Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.43.5

