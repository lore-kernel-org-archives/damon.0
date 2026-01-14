Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A4322A2A
	for <damon@lists.linux.dev>; Wed, 14 Jan 2026 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768359463; cv=none; b=U4/jrPCytO5vB9dQ9Be7IAlT6LBXWMxYOKJDYiohBsOGURTlmhxrhIWQOQzAOklmvVEvNAPvVDfh5Vrx5tnTrYlTEkPyQQKY+q7uE9JzQnqY4pwz5M7frB43Lr9/HbwFYrN6kQyGbCswKeHMoDBqhgD63CReadTuzzhWHPmnRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768359463; c=relaxed/simple;
	bh=/9n4lu83n7QsMPkx8T9eR/O8D9ERtP+wzP4k4ZYRQXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjNrbaBzHr5kvsvSwEw5lRw/We76Ewy9YMZxuYjS8Y8UkcTZ1ws38m1d5yOwH4AEENpynUhrOW+yxSYqSL0MzgHORqmneRpt7h9oJaKupdcyxzmOGLLm9IBG3HRoLBRdB58mGubIT+knTrA6olqHsmivIqteApMkmouOBBC6Zl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaBN8BOE; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaBN8BOE"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-121b14d0089so9288686c88.0
        for <damon@lists.linux.dev>; Tue, 13 Jan 2026 18:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768359461; x=1768964261; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9n4lu83n7QsMPkx8T9eR/O8D9ERtP+wzP4k4ZYRQXk=;
        b=aaBN8BOEK883LpMh9K7EFjZEETK2Dai1hqMYAlrsOvTd35z5H2fWASg96HTubwEB3y
         JtYLv67Sl2DJGbzZT45+K/P/wVUE4FzkIqS+9ViYTvz2jlZpc8kug44msixthhpXOJMm
         PLUA6Uk5V4fXFgNZ1eW0jkPCRjCSoXA6+EnFIgdxFWfKSSQqDLeI4wwR30Bi2jkdc8pN
         KK5bG6GKQmXioPXDRCbazNrBhH3eSt3wDPln4oVN5Tf1bvN8IuwTD7iqUgCVOaE3B7Bi
         AsrT7Mtf6gWEHKPyT9LXaj+TXL5RZJHefDQwiqsEkImVMiGgcomzAvD7noFAuGmmBbjk
         ncvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768359461; x=1768964261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/9n4lu83n7QsMPkx8T9eR/O8D9ERtP+wzP4k4ZYRQXk=;
        b=EHoQeo60sJrbfgHtJq3Ih/m1bO0xk814hX/9pbjhQ6scLhM5ywkhmcTWIRKgY6cIeV
         HCay0RBIsNAtSMey027+vj44SjqdgGdaDiGmA1CBhH44/FjqTuTkJnnjXanSZ0Jj+mpv
         D4hPBoiWEm3xWQ9Kkn3BG8O9XwTEan2v3nCT9hA54Y4fqh31wTAD2Ol9cXvBykVWqrO6
         PTJr0JLf3JFTA3tRCmNjSO5taP5dInz5/4ZkbDwbDAoOIJzhI7Yf7tK148nFu93p87bS
         44qTq59BU4GpNzmvT//ZZ1sKATMOxMEn2rq0S+TXdHOxrF3WHJkJQJZP9tlSaYlmWhMi
         7loA==
X-Forwarded-Encrypted: i=1; AJvYcCWy/TcdagS6sMpRh9oCWYZlzOaZ2t8SAh0H0U6JfEF3bihzOSm/tAG8UTrXOrwphyLyLklYhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxibY70YuBP+2WytvzTWcs0o9Ikh5+kEbeWwDjqcBchQnLYqMPG
	j8hCexqxB9QWlsIBIOqwo/jwlb32sn7D6X8pbqgUCYM/wgI3OjmlQ1ef
X-Gm-Gg: AY/fxX4uYApzXbdmLWj3VF7LDijEKXO12T0XsmBlHeVTpRpmMRRk5BoTHg5wiOQxkoP
	Wx+Q29O0pi1hh823284VQp9nXN1fmogQVlIWlm263tg7l8N+ux32ql9ndUbbwz2N+M7hMWPE2ah
	pdDZhP9PNApUR9A/p/FLOhKZv0fCc2jUIbWBRB7DmykAecMmgXKFp/IsmZVXtG57yRSTOBEQ/4V
	nk8nej4xp0vphyVBaCdD+u8vINLXIabgF3dx/Co3lSUOZJQLiMifmWGAVOqLcR3A2B/EBPRlrkO
	TXbFD1SiiBvz9sbkVway/r6MLw0bgpxyUDEnFqY1d7x4MHsMG1ZXBekYphOB2y8kcmu+8qdrah6
	A3TkbcgI7sKIcTbawc6jBN1bI/kSavzvsAfHDW2kVL+CaHMvJokXfM0pGyoSrkJ+o6sUpCnIurA
	Zz
X-Received: by 2002:a05:7023:88c:b0:119:e56b:98b9 with SMTP id a92af1059eb24-12336a678f2mr1141773c88.32.1768359460751;
        Tue, 13 Jan 2026 18:57:40 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-123370a051esm847751c88.15.2026.01.13.18.57.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 18:57:40 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH 02/11] mm/damon/sysfs-schemes: support DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
Date: Wed, 14 Jan 2026 10:57:25 +0800
Message-ID: <20260114025725.81738-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113152717.70459-3-sj@kernel.org>
References: <20260113152717.70459-3-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> Add support of DAMOS_QUOTA_[IN]ACTIVE_MEM_BP on DAMON sysfs interface.
> Users can use [in]active_mem_bp keyword input to the target_metric sysfs
> file to use the new DAMOS quota auto-tune target metrics.

> Signed-off-by: SeongJae Park <sj@kernel.org>

Hi SeongJae,

The sysfs interface updates look correct

Acked-by: wang lian <lianux.mm@gmail.com>

--
Best Regards,
wang lian
