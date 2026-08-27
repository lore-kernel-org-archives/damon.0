Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A08349CD2
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810573; cv=none; b=lY7qM+3J5xWeNKPAbvxLImhBFD+G39DiL8Irx5+qEn6XXBuhznOhVTfwD7WM0WTaQrgyAwIM4FQCPqLlJL+sz4sRLZ9Ynh15W5rFalh+q1meo9itASxdNc3evXCidbtI7RthglCjPtzvPpiYzbin1YEB3MbWjZK+Ire0ZW7Ppqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810573; c=relaxed/simple;
	bh=v0DkDeSeO0CyaXOKZU81dJii6FE+xouGX6RiJ0zgFDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgxuD1szdHB3vWn4N8ZUIEN9cA2qiNjSFthPa+7VYOdIWrTTp6uPxJP91iVUeSUfVR+vdJNeDcNpfyPesfjpUNiCrddZpD07ESP4V+TIMvSz2PiITu1jh8SDSu7dQU5waCDPosPP/Xz6XlMNimJ66nPdQHQatdqFNvZFJjvm6bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2NmfeGi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2NmfeGi"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-854f8068301so323540b3a.0
        for <damon@lists.linux.dev>; Wed, 26 Aug 2026 23:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787810567; x=1788415367; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OIuQzA83NVqtXzGO6/EiDWZtsLFaTyo/lSlonpMYRbk=;
        b=F2NmfeGiOzmyxSq2DGSVU63ZDjlORbJnlUt7TU2GQWGw9JEzDVCmc2qPvtGxFcFyNc
         1YOhwVXJJXM//mcqmXGsTJTs1xlAuGNiFAlZX1LlgXalu+dhfhamoRKKPjtacNAA/RaD
         Cr2m9UtOU5OHPBW4LRnBZE4Fn5q+7tC/6oDj2u+ZPirUeUoxF0Rv1P9TTHIpf8d8SBA2
         0YWbYHc2TLXmEV3pDnsUib0vJUxnIr/ipcsLexP5Xqe9s3KkTXVoS7n1PSU3xR1Qyazk
         BsRXE6OyxjZha09GXfwGluh3RNQz1OPgCrqKm7JCahdeON20hxuUY73UvM6ZZkm2PX1n
         mJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787810567; x=1788415367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OIuQzA83NVqtXzGO6/EiDWZtsLFaTyo/lSlonpMYRbk=;
        b=YpkZbG/DX03BGLu4MJqf/q6IWMPohKt5L6/g0xsRL3S7eidiaOISv/vra7ux4fDlkH
         vMtOlTZ6jmEjjWhAGYpt0bn+hr/7exymfR5VfB3/hW2Fr9ZwdO/xDiUFmAOkjjwymax6
         IdbyXZCByVmfMh5dnyD7yp0qVH8I/KoLIsVnxDWadbQ0qLxzoRtGIuTwSKvhfqs2DXQZ
         VbyH4NyBgx2RLv2MKBhV5wNvO4NT6LJbq+LqoSIB7c9xcvhhJpP+giqhOfxb2wfU48HX
         qcKVYFwg4nfTwge27LpiA+FQUM1UlU2bihxA4JJRfSh/xe1XmH+6om0GqdcxCn8GXwqL
         4gMg==
X-Forwarded-Encrypted: i=1; AHgh+RqHH4dO0BX8tS9rdDg52mi287Ltcksal3Yx/v/aYIc3sm7TVhzSi1AjW0ygSVEemvD8rZeNWw==@lists.linux.dev
X-Gm-Message-State: AFuF++k10oSOaZR/nlnxmtmzA9ntBnJV8Ttn6oO5ikIQnnIdnCnLFZaG
	hhnaWwEMIhzGdal4/k/f9HZF+1N5s25kapekhxedhcitw6GopP7gNCxc
X-Gm-Gg: AR+sD13oZ0/E5/rylHICX4eTB278Juib2t1zGsq0BNpO9Ds7gJMId3zCjnk+5/9TbP9
	G/w7DIVzQSodcMIjFhFu6KF6NlhHBUh/Z3093Ne6+4fYj1+VylKs+0V9cCQvXiXStvZmSakLSin
	oiPtHckLJm1dZEfRFGJyrsBftaAYzuNynOJRwXgDLfenUB24igiXeIM50j5mhZa+VOxhnq/RL6w
	pPZt46ni9wuOnUTQJZmQiLHUiL3qI6aL0OMSCt3GJE7vjNBif+rOtO/cDYcjUXw2culLqdQqNrg
	9GZ4xc1jtvGsJEDa36qOzPRi+1oW9bmHRToNyqZ5hC74eiCXvAj7+hKWjQ4ytvM2CPg7P3uGQ0g
	Vuc4PEMZy8QyxnSH8G+y+PEPPae7X9wM50u0IS7yW27XtMHennYj7r9GuyD7IqvAtkyYUbGn2Ri
	g8qZQlWU0YdHFmBcGNrMwSeW6HID21TCc0aNm/tOswKpio23PxZSHjITQRGSlAqogJ7A+D/014q
	OEn
X-Received: by 2002:a05:6a00:8c5:b0:847:93f3:a4b6 with SMTP id d2e1a72fcca58-85375ca6acbmr21643818b3a.17.1787810566706;
        Wed, 26 Aug 2026 23:02:46 -0700 (PDT)
Received: from celestia ([2402:1980:88cd:27c4:5897:46d2:587d:19e7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85359cd71e2sm1648618b3a.12.2026.08.26.23.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 23:02:46 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Thu, 27 Aug 2026 14:02:55 +0800
Message-ID: <20260827060255.18114-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827055426.16874-1-aethernet65535@gmail.com>
References: <20260827055426.16874-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Apologies for the noise.  I accidentally started a new thread due to
missing --in-reply-to flag in my git send-email command.

Original thread: 20260827004438.82746-1-sj@kernel.org

Best regards,
Rui Yan
