Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC539B972
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517973; cv=none; b=m95o/5q1dzYJ6rUOAinMnNNKCol+0lOruQVEsLnVp2wr3HtXZDSE12o3dCBhFEF+qmNLtWdokFUaCrc0KXLHHLFailMaC/ga8iFyi8xjPM7c0RLh9ExdV3upfIbO2OOO56e/G9MIHdvHoSEjRa40nPNNlc1YoMo1mSZ9Ei8fbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517973; c=relaxed/simple;
	bh=ow91Y4E1mSY+pmX9Of1DnlWzxLiCg0lkZOWlo+tNkOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjuqKm72mmOb243UegTF/A3lGf0BABhpI2v3Ili40WLaNPTz14p5oYIWWgWu8u2udIhooNy8lLlDVofGqZt9YW0PAEX4YaesIrQ9nrV2WFEB08D9V/q+rS3M/q6RwR/oIQ0tO23D240SuQ6EFj2PPv/yHpaR2VDncjK7OEvmjq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkns5HiG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkns5HiG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495522bc0e2so195135e9.2
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 23:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786517970; x=1787122770; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prmr/Jndi+BNbM07sqH6cB8cxDm8c7W6tjC6zXyacuQ=;
        b=Gkns5HiGaVEeW2wICGlDbLQHk2/ZhYvETKvIOttjvM9kKyAalWQi1LGyX/iR3Nb7pf
         RdluYa2RgNXrfDgxN0Iy0jVyKFEp3/GhwYSz/r/MaPS8+xnS4Sgtp4aeO91CZTLVRiEc
         Y0KcqZ/JIWRpP6kgINJ5SHGWo4brqMQsOxbwF+johrJiGVOwNb3ag3q0cLGa1W731bqJ
         ofpwM5aKbgM2RZmV72+1Mcshpm0dFnXx4aF5OT4rkEaY1XPfAkXYrJXnfcboq7QitLyk
         b3JJhkWl5p0KDvsjPOvJE0LN/5UxjTgmgQfTj9NY16QdzwNA+8ITgGeLZLUqtenF3Dxq
         pNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517970; x=1787122770;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prmr/Jndi+BNbM07sqH6cB8cxDm8c7W6tjC6zXyacuQ=;
        b=FO0TWG8UhtyJbwa1LEAM5LOGhK69US58vElGzPCtdjYTEt4VxNf3s8bBha/4HBAyGJ
         hBAhnrtRsZqXd15v1/VSokXOyJ0JrZmXPkhmCnT9LwHleYvGg63KJZD5gsBsPaEOQsKL
         yuOp68/3QIwEGJN+AJCiyyN0M8GI7t0oGi+pjecu1z7WLnF77oZzmHnl87d/5OhzWfbs
         Lt50npRgGV6503vRcqUJOp+6gXKeQm0ApXsu/uX+9/ar7Pw/3HTd9z4US1i2u1tQZNou
         TRFzQghiMSSHtSXfigerMNmyc1MXAS7cTYnIfScxBrQPljxqg+cVAa17XMykI0ZS+BsA
         e3CA==
X-Forwarded-Encrypted: i=1; AHgh+RoCPJZmYm7wnDzqlH/ErH/RqlYMbEZ80zdFf1inNwrPJHjQU7B5yyvZR7/lhHyltfQ9RQCmLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVv21fYrj0NRayy1SJ943ZFgsPYsNd4zt+wSGRYumjnanfPVDZ
	BCanktiABsHW/na1oe7ZlHTFf55err+Fat6KkZJ28gvWFiQwQ0/bzB95
X-Gm-Gg: AR+sD12ULhTx64l21qnt+agn25pCagHdHJWFrBy1VrlG1uIVMuo00xa1aIptTlPI2rH
	W9lCwbEzddSHGs3Dw2K4AfIccs25zgDnycEbfFMcr/V8c1wGBkzu21b06s+n67M86eJBfjs9VIO
	OUUAzD2xC8cdDcXmNcMPQ06MWQlbTFCFBEtwN436/OiACi0myvrYeONMQjvRQ9BdvJN7wkTujAB
	WDaPeCu3WqBTc2axNQ95DtQ2DmsDQbzKxH8iC6Z8qCdDc47Pg+RZYmfMH0Kzr0BofKQKCr431GE
	Rv75YUlJ1NjDfIW4RmVBdkvIJS3xMzC09xl+YQVXNngG+Qpxlx45uEh6HBqn9p0d28thAHdZUrU
	SDquhb40YqM6WTiROdZbtU6BfEaxzkfkPNUKwRO2QBBq6etMETlACdCK8QdD/M3qdxKtb0FCqkd
	T26roN7unIS2ODFGBy1c61qrTDvGR1J78Z5vZJcN1Eq0n4Jqts0sw9jCk3Ryu3uV6qt/VUxgTIY
	5+k39v5+b+O7RWriLsD9eK094u/D0EYZazriKbGP9qZw3hFGbwQFh4wm9xYnoTrwl35q1uRAXTO
	AGgg1u+rMBKhB5O3YNYjCbhcaNo24Jnq5PyI0b6wRiYpew==
X-Received: by 2002:a05:600c:4688:b0:498:8e6:d463 with SMTP id 5b1f17b1804b1-4997c0ddd6amr14974525e9.1.1786517969708;
        Tue, 11 Aug 2026 23:59:29 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b15b807sm73628005e9.7.2026.08.11.23.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:59:29 -0700 (PDT)
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
Subject: [PATCH v7 3/7] docs/zh_CN: update DAMON index translation
Date: Wed, 12 Aug 2026 06:59:07 +0000
Message-ID: <20260812065914.3071433-4-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812065914.3071433-1-doehyunbaek@gmail.com>
References: <20260812065914.3071433-1-doehyunbaek@gmail.com>
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

