Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F83DEAC2
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496009; cv=none; b=IOwPHlCPzRC4IZkQ58kyOgoeYn8pZPzgM1dL+gM3rVYQPqb5WXhGV06jfTi4MmSbgvxofI19E4xTlqlVTCBhdbqEwAvSDvrCC7jHpWOzVei5N86oMi0Qv1nsaWnxZwg81PXgxp+Vu13hHLWsIGg/+CcCdiWR/2kBCfxNAgzrHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496009; c=relaxed/simple;
	bh=ow91Y4E1mSY+pmX9Of1DnlWzxLiCg0lkZOWlo+tNkOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+T3e6DVeC+Tr8YK1yRGnMEHtlx7brgECxIenFppHzJycj9GfcVq1z9Wh+ja48G/8iDU7tII2j0XHjt/JkSSkMpk9ZyMfepkC7vtlaAMRFwQmh3jgehYCEpiA4VAFIXgdsCR1Nx8jhiLZDr6oitVSkmu1VcgLyesvvmQ7gat0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpDtedOP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpDtedOP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c2c7770bso332635e9.1
        for <damon@lists.linux.dev>; Wed, 08 Jul 2026 00:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496002; x=1784100802; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prmr/Jndi+BNbM07sqH6cB8cxDm8c7W6tjC6zXyacuQ=;
        b=kpDtedOPaa0P/Oy+PbIrg8EnJJEivBWHzZr1/TNuSEY4BuA18+e6a9j2e+f+Lx4q0/
         x9OY6nx3SvkHRc4iMp64Pzz+MOq7tcjTaShdB8hkKyGerR5NKrlMJhyeh8Oy6gAojX9b
         yF4iwzoyLU1QYEmP0j2/o1wWX8uCflyKlfdhC9azcaWY2AxT9q54+dnOwGkiIfaCb+I9
         /PT3jJns2+DSHB4CfjeuyKcA+g2VfA+ouYbkpQwe7hbN54+hK+TU4NujsyzQfgQWIJq1
         2nXqK13G9x78Gu/nkXN4A3QP4SvNtT/hsuan6n9zzfPv6A9E/gQsogYh2ZPadyInl/X2
         VIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496002; x=1784100802;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prmr/Jndi+BNbM07sqH6cB8cxDm8c7W6tjC6zXyacuQ=;
        b=q3HUeMR3Wi1atl/QBgKeyZx09jM0BLxbOijErc6CttubI7HAt627t4eiKHQsWboieZ
         QksghLCJeoi0h7Z5+CUTEzvH2RSu5bSTL0bdInzmfb1U2JTlZgj5iVp8DmQZpQPbeIrO
         gRpwIsGI6EjWInyT41OzIteA4wG+1VOSHc8kw5AKPUdekncm5nhPj3lQhupbGVSZ/WdN
         HuOSmP1aT+02ftKVlt+gtxa15Y4KI/JVQiAX1JBsG5Ktu2/diMIifWZKd+DQI2vezplY
         47SL7/tVGfOUAnQN6NXCxHeiHcB4mcYyF8p5Oj1z8zmtAz+mmyZUzzK7kwett5KRgiIx
         G+aQ==
X-Forwarded-Encrypted: i=1; AHgh+RoALKhJY0y0nr7FPBHrrDM8JS/VMZq83W+hMykde9LOsDjlzVRK2VjJfS7oKgITBjHd3NRc9A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb4qwu4HHf/bc3pIdBHfgPBB/u0z/Bg0ydFbtTso6BXhJN4Vqy
	WPlQLrJ3LdYAHQKhJUSc2xbNOOsvvndFV3PZm+lSZjZBr0mUSPZYlcpI
X-Gm-Gg: AfdE7cnb4xvMNC9DJbnNKxI1i0XoQhb/n3/lDczDKO+qEgUwzeZYNuhFbP+cXtB4EEA
	8z8jSFt0d8q1xALwZpa7khBu5U63d4M7ctZjK8IoDL6U3T9lDD4KzqvvLnOF5RtqHqaFqUNlLdi
	wsRqPyWixbc4Gmr2Py7q1aTxtzHbLvTZhl9IqHlyZtlCH5pmQYGupwefMsGnAJgmkFphRDK79tK
	0rkm00ik4z0TE6nEnDBUR79XWYtdCOww7oHn84r3Kpo36HGNf+spQQj+rWL/9TlSiuPWtcqTiqE
	sG8+m5Fmxrt3YgvrmBgYk6yiYaxk5KjDDrpIf9td5/XOcXWJRXhdjmGQ1Ct0DMuj4je/hSYWRIo
	gLNYbWV3xVezOWrdeD/VAXiO1PV57VomZOJw+1wjQCR0fSxxL8lJXtLg0zhBbXu723NLlcLmZdN
	l6LkJqz9g2eZ0DNRMzok6QcQbNA+bH2SM7mXbL9rot0K6QgVq6aO+11zUDTCeqmPLYGoerEzQfx
	tOnh4f/PQCkgGFP
X-Received: by 2002:a05:600c:828c:b0:490:b227:da9b with SMTP id 5b1f17b1804b1-493e6820934mr7102715e9.1.1783496002095;
        Wed, 08 Jul 2026 00:33:22 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e610532fsm32876355e9.0.2026.07.08.00.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:33:21 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH v6 3/7] docs/zh_CN: update DAMON index translation
Date: Wed,  8 Jul 2026 07:32:42 +0000
Message-ID: <20260708073246.1652828-4-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708073246.1652828-1-doehyunbaek@gmail.com>
References: <20260708073246.1652828-1-doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the Chinese translation of .../admin-guide/mm/damon/index.rst.

Update the translation through commit c9380cdd949d
("Docs/{admin-guide,mm}/damon: fix DAMON documentation details").

Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
 .../zh_CN/admin-guide/mm/damon/index.rst          | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
index 6f8676a50b38..77bbfa7c25dc 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
@@ -9,12 +9,12 @@
 
 :校译:
 
-============
-监测数据访问
-============
+========================================
+DAMON：数据访问监测和访问感知系统操作
+========================================
 
-:doc:`DAMON </mm/damon/index>` 允许轻量级的数据访问监测。使用DAMON，
-用户可以分析他们系统的内存访问模式，并优化它们。
+:doc:`DAMON <../../../mm/damon/index>` 是一个 Linux 内核子系统，用于高效的
+数据访问监测和访问感知系统操作。
 
 .. toctree::
    :maxdepth: 2
@@ -23,7 +23,4 @@
    usage
    reclaim
    lru_sort
-
-
-
-
+   stat
-- 
2.43.0

