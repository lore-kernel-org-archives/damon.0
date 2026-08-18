Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4912E8DEA
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036712; cv=none; b=lqLoiFVr3kqcjdN25rZ4stY8HhB+Lm/7DrFfh2Iabtn7kEtfJQy2B3B6+JcVd3yJiqZLpAgppD+y0dDcn9dnyTM2QvDokkdpIiQTeH2qUhuGUlaXPn+f9adutLcB3yypr7AhfQksv8dhE+eraYvtgW1H6P9uD6l5HICVcGAQwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036712; c=relaxed/simple;
	bh=ow91Y4E1mSY+pmX9Of1DnlWzxLiCg0lkZOWlo+tNkOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SECfJNKZS+12E4kRiqO6DEZNnJkRcmZf4ssDdz4Fa4zyet65rYDescOdcN7gqQRuruxKGxRfGamyg1CbmIIOZtV9WruPoYiL52oxbYssjNdqQOJrhPfHzR8fjKyHOPA9iKrbM2jmlRrfuO+3r/XFKHR/l00ZGE4wmfKRnc/p3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3GQ1Co7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3GQ1Co7"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4996c452e95so3826345e9.0
        for <damon@lists.linux.dev>; Tue, 18 Aug 2026 00:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036709; x=1787641509; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prmr/Jndi+BNbM07sqH6cB8cxDm8c7W6tjC6zXyacuQ=;
        b=r3GQ1Co7fHQGOU6paCiwOgqNUA9MVbLUzsn0X6eLE1w0UCriVSpSm2fqqicP3GjYFV
         aejlFG5kXC7VfCZKvk1vxrwmzyMm0SDRbve8gfUQEfEuOU7R4cwoMtFr2YFR+g29EPej
         4DsF1PwB04PQmhUPfrxGv+mrNhgsg+23glTGwOzwgqNzWFC3ttmTlCpCUOWjMQbD3VWv
         Bj5ehg8HYnmg2G+UPbmkVmBw5Gu9XZhfsRoUhGfIOfA3OHHDED1PXGgWkAQQck6oc0yh
         Q9j/449GePFLcPxPSei2rxg5XlEQ8klTwOvRm24OEbmElV+6losmpQoCoZ2HZf0dcdUJ
         m28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036709; x=1787641509;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prmr/Jndi+BNbM07sqH6cB8cxDm8c7W6tjC6zXyacuQ=;
        b=GF9cvgX1JNY89lOwFNsM8A71SYOJfUIR8OTldsAQOzgJEY4vbSif4EDeOvL28ROh0M
         XSPsByjNVKb/FI05HBdME3G2oebYNf1/9f56E28V0q7TKeMPt0t4xRmAknbTsH9jIBQJ
         zFzXwV0WXEc5PV+x4AD3TJInM9yXxVY5g/bfUu3E+OOtrpGrFUKbPfBWal7dRHbUwGQW
         /9rlLy/swDWpyYMB0Tmf/OZUfxZTPW4kw3+RCOIMnMAIh2XRqmgfbRHGjrik3RstE8bP
         WnG8pRnbC+petF9SGac6Y6mDBZ9bcnxqdexBo99dlSPQJd8CYLHYvLFzqj0EYawln/dH
         uQmA==
X-Forwarded-Encrypted: i=1; AHgh+RrZ6xULOSJUgeFCZ8dYg/g8jkaVsMBeOaoyL5aysdRA3qK0/2qCZ6i8xNoK5mbdhja66jhF9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv5jBTN8B+wgtHzeQrPiOERPYjrvLWdpNuB2GpLIbqWoVDcXDq
	e+7GtXeM8T3K6vn8xtJpWoyDvr+kqjrnT21HtczI7twN0dhATO9+ew+F
X-Gm-Gg: AR+sD13gnfPlh5xbKWCLIDej/EKXtqqTS2pSb5H1/EKbdZqqrX7gufN4Ww5INxuA5HJ
	FEWugk860n4CSo6pr1e4d13W1jdlk4iQMbBxYz+aBdOXZwobWpN8LyKr6DsAqJmcOwsrjiBS8IS
	9XRpkvtr8mw4Fq0GkRlB4BHuZRBzFvgxf6vp/eKvBBbwwJS3igxaGjnUGR8RWPPiJgzlpqc86SL
	hLKjg9vi2apVZZru0vasrjt0fWm5oPuRpM+OLzyLJPfWwHxdretcf42mlZb6s54JXD3d+ez4Fg3
	pl4uea6y8YFCIy8Wgpazv4XQ7Loogjtzf7HIrZcKj172kgImd975FP6tv45wdesDHgIJlQwHvEj
	j0Pbba0OQhC8uVxSFVFXAip+d+JQLGdWtb3Joz7S9EiCNp89RyCqXJOPfeKEalOIgS4nM6AKWiN
	QaD8wGAogjX0vHcecgEgHNkIESuxTDVQnzUwrXS3pImQDjprD2osdmZLmPEIZMHWQys/rbvc2k5
	huggxyZBaW2o/SZ7glzsbKKCeyumvSpQN3WmPJu7BYbwcJ2LAGQp2trXRk2Ws+9D0kyCdNTl7Pq
	8ykwBbab4LWvchbUjQ+kmRHCLk5RWMcAG4DGLccRHVJ+0w==
X-Received: by 2002:a05:600c:1f91:b0:499:59da:12b9 with SMTP id 5b1f17b1804b1-499878cf8famr209718415e9.0.1787036708705;
        Tue, 18 Aug 2026 00:05:08 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm495557495e9.13.2026.08.18.00.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:05:08 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Cc: Doehyun Baek <doehyunbaek@gmail.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/7] docs/zh_CN: update DAMON index translation
Date: Tue, 18 Aug 2026 07:03:45 +0000
Message-ID: <20260818070358.455768-4-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818070358.455768-1-doehyunbaek@gmail.com>
References: <20260818070358.455768-1-doehyunbaek@gmail.com>
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

