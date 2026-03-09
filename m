Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909FF13AA2F
	for <damon@lists.linux.dev>; Mon,  9 Mar 2026 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023314; cv=none; b=hvnCCyePBLZMiv2fHmln4zaHT0LRRvlKzsRa53HK6Eeb/7GXvbfpD+gwJT8piCbDYecjDdRTeb+tZdSmbmgARA6DQQzZwIvdL+iH2CI8aUpS/qaS/osm1rdUmTsjRmIZaQDrGNEG8YlB25RhNXR+bp+MUSAEwD/3CyrWtK0YisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023314; c=relaxed/simple;
	bh=0PnHXD/eeR2S7L31MiPzD6lKHnVR5jRoYM2/It/mKp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2zTW5GL0j5FSqoad1F0qES5xEnhw21xH3usAcHWs8IZTWEDWwkzX+T+C+XuGkUjKYfTUsbmqjkWvObrF65pZa9Xh1pSYuldeZvXOEKeIMmmilk3b7AdEQH6kRCpwL7TvcBdSvDXJhgHUXQHAXlYuaG5yXs0u01MdV1ZLyTW45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh5FQmks; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh5FQmks"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1279eced0b9so10086929c88.0
        for <damon@lists.linux.dev>; Sun, 08 Mar 2026 19:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773023312; x=1773628112; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps1Hfv9yWFYK/K2noVGj+dmwqc5tyuYyDUSGFJyxTPQ=;
        b=eh5FQmksLCY76GLpShqLzKHUOuyLwLRWBTdVeIKLndaFaRsV4wia0WASlzyI0zPbsR
         f/2xz9l3kzeGN/Sb9mMN58zZZwsdHcjXj4cWKqjCM32vnnqE9yaHQ2TjcD5ohPVog8lp
         8Pdrm+qgjSKRgR3rIPFCt+LaQdNInGu/8zgS8992DdC2g5WP72FIr0om9pLJMTU4yA26
         YSPUEayx45BaOLOa9b3tqLI3qxfxP++HG8T6JAE0Y6ElLPc+JyuCG30eGRCywcNF5sGV
         23gJw0SJ0AsLlbNPjo5lplOeDkCqeUaplbZ9Vket9Z3oFZ89iRzKnzVdE74ea96u8tsQ
         BM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773023312; x=1773628112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ps1Hfv9yWFYK/K2noVGj+dmwqc5tyuYyDUSGFJyxTPQ=;
        b=sweBP3bVkenvyPwNlQEMlJtjAn10qLTuvyF1zaOLAZBhKC9z9jmwv2eHazL56Ap/Tt
         kPvZuTDcl6mg5/I7YL48DOLSgRjcAcdTvi9MpuAv/5UIV3RvgFM2t0CbnNJNJ+9CqhTg
         40Yg+p+/7nsmcnv67ffQDhc+/pC5jOMQwfw22kDwgAa8k9sSVAE1vkIA2sD4kHiSjQEY
         LwW4tKaakXCuBjBaP2z/ShgxqrDt3SbVkbc//CjV4B/7MhbEifB+4dEharcfuSkAkoJX
         CMFsx0nsUa7puffDtprUwM7BVEl0R78XX5h/TCmFjQMSXckDfNhOXRmW5Tw6k0AQ1/f0
         zc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0fuv1Slq9BFx89K2LwH9/TbsSXAafU5STtWc05JEIRIDEbXCeYOugFjFJA/FbTq1PXc4I2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvWSq2MgY2dC6psv9z3bVaApq0nhprHx4eAIhUh9cfY7NyPxKy
	NHT+f67wzP87W4kTdU/tVQ7qd+q2e6B1q4o278/cDY/B08qTrF8JMTsl
X-Gm-Gg: ATEYQzyA9fUVQixNvKBCtMY3Z3D16C7/A1aq545/acTnigSD1QGHScEHDR8FmOmRTpw
	QgU1PjVDc23md/hKTiGO091ATKm/0R06NDdNYEtmWVreKnlUNm5UP4vXNbdGeL57NV03tzrqud4
	59w6RmsxZ7DULIGz/rHxB6/STmB3fCj1oVDrMwanK6zK7NDv/olfnhZj0enrm9NcMuNSa4Ztl2A
	wbfoR9hTzhxQ9ovJ6PvANqdhNMH3ai53bEksamTC/IBPrNt0IhgcP6CPaNtKc4MxCAmNst7AcpS
	rzcTvHYWMT4goyYw8wUS/Ql87Td/NUxlItyQ3DBquCy6Wdlp1p8MHcLSt54BwxrIQDlLMuIIH8c
	/BmJqOrGk6+wkm512nB5N3Yitbf9MLcb1n9qg51r1ZIOMtX1uevOFvfdo36pjxwpCFWIlMSFw7c
	PZtZoyg/f8RQnIvuL7QNEquUBtq3LZEyhz2ug=
X-Received: by 2002:a05:7022:4186:b0:128:d5bd:3572 with SMTP id a92af1059eb24-128d5bd39b3mr713023c88.31.1773023311637;
        Sun, 08 Mar 2026 19:28:31 -0700 (PDT)
Received: from localhost.localdomain ([104.28.165.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3d5a85dsm6728418c88.3.2026.03.08.19.28.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Mar 2026 19:28:31 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	corbet@lwn.net,
	damon@lists.linux.dev,
	david@kernel.org,
	davidgow@google.com,
	kunit-dev@googlegroups.com,
	lianux.mm@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@kernel.org
Subject: Re: [PATCH 0/7] mm/damon: improve/fixup/update ratio calculation, test and documentation
Date: Mon,  9 Mar 2026 10:27:59 +0800
Message-ID: <20260309022759.9010-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307195356.203753-1-sj@kernel.org>
References: <20260307195356.203753-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Yet another batch of misc/minor improvements and fixups.  Use
> mult_frac() instead of the worse open-coding for rate calculations
> (patch 1).  Add a test for a previously found and fixed bug (patch 2).
> Improve and update comments and documentations for easier code review
> and up-to-date information (patches 3-6).  Finally, fix an obvious typo
> (patch 7).

Hi SeongJae,

Thanks for the patches and the CC!

I've reviewed the entire series and conducted functional testing on my arm64 environment (native VM). 
All 28 KUnit tests passed successfully, including
the newly added damon_test_is_last_region.

Acked-by: wang lian <lianux.mm@gmail.com>
--
Best Regards,
wang lian
