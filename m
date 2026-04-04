Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53ED2BF3F3
	for <damon@lists.linux.dev>; Sat,  4 Apr 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775293769; cv=none; b=mMD1hnvRFL2khP1Md/Z+ZA+Q49QJ4mxOmy+4i8COJmjVSuLTB4JCex4CymleXVKW75e5pEAs9621aiMq9LR0EYNX4nRUARwtNdlsHXzroXSDsNnaalPvmFNO8I4qk40S+5QvdlbYxwRjeerjdBY/Ak5eO58TckUDbIHVvTTzZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775293769; c=relaxed/simple;
	bh=ScG8uVSfiAw+Bs+s4tTKHN80PAHx4mEW5XgDsMJivM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEKw0nx4Uw/rI3POkl4OQ+/u6SpfI7cjownxzS0sZLmbTRjDqkoyN4swq4Z6v/yzQYTTCZNtM2ie6aUDug1dnHfJgg98Fv8mokD+2qnxJn0r3d143qkcbQRgmE35LnJFZlkSTLrQPQbSfg7MdRH5qwTTQv1Nznt4rRTXNbnHI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqHRY5Hk; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqHRY5Hk"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c757a9251faso778784a12.1
        for <damon@lists.linux.dev>; Sat, 04 Apr 2026 02:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775293767; x=1775898567; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX1j2jpOZX0PU8n9tvbFhEKNcKUBE7L3QlUnR0eBVu0=;
        b=sqHRY5HkrnIYN7OaI+LwG4aFFzaJbY4gFlcW5EjG7kWnXfvFG9fTiKin/jgJOJQGtp
         0w5UFfssGaqOfYcX7FaaNh4+emshVIxie6spMENQ4XydmQxNPfRyeh8FhqNvP0coPnmt
         KO0s9dIUOqG1pnoVyQGYvp7MMl5auDwJ0zibmgAGYJEXbf46X5WghE5rQpZlkIq7LyQe
         ipr8RdPIi9TiwiLbFIt4GQgrJxLSRR6OlFpUaCrwnUKI9I51mUz5m8UFqdHd/X9aWtLe
         6kuWb0VVxyNeEzH3WGzRKvX9yNtLTv/0WDAnNDxSq8zjEpt6ZFBnO2iYf3zw+JmSsY7z
         qdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775293767; x=1775898567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SX1j2jpOZX0PU8n9tvbFhEKNcKUBE7L3QlUnR0eBVu0=;
        b=e2HoNi7wJgfYS9/wb8Fde04KQXCFbzEEqbZBnqPol1JJOBrpWZT1O+JHf3QstKK6H+
         IsNOepeuy0FD6O15iKa4DESuZ+DUuFrSdiQiXMKgr64h6adGwaIQh07rm1nlO0Gi2Aq0
         SvppLx/45oTxT3Ha/0FwgyuajgU+tnsDQ+nNRTdhKmSkE32RvgPLtBlNVCJ1G7F5m0x+
         GgqyqmpShs8MGFezsTmMOCZOQo1oOJUF2baWPljUNsQjeJG1dOI9HnKURRvyFFJuqoNZ
         LfEwfNGmPuOTNXR7EVzX6eLgxbx/Jh/b0Rff8u1Zm6IXNpdBP9dsJDBgL2KYQaYrR6xb
         y1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvHvQ2gKlsrH5K3KH8Fxv5Zje3Oo75y86MlsmhPBdU4C/5/Jel0OYqTjLzTqvWVgHvcJU8bA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/5Be5A9at74mpfPTwtsTMoB/VTuKCXEUBh151va0IxSrhhns7
	TLpY4RPP9KTpJFGqarT9l1ubBsllM31If/PAErt2WMpIF9pbFS5UqQT5
X-Gm-Gg: AeBDieueQ0f3+79mp/fB4uuPUC8ayncLJcupBoSLWMAkBw9bC3uLiyk+h4puHB76j29
	hLQQcqfxMuMHBDiKuanlYtWgRipg5zAsh6sA/mChZYYKJ7cLv8qaVl2UX40gj2cbn2YlxNkpNey
	88GLelwyO/rNxsxRrrNM8bpWof9xyNUH+23mtPoou+tNURzjPfk9lyBcAU6e9GOgfhe+NlWAMtb
	VXGlVgGTXdTD57dZtezvVsyjE5FqqCUwR+sjtdvTR6+GpMvauKZkFkVRuUKPRhw4D4LH7kL4v+r
	btCdjQRe7vEyvMy4fChnoaX0sYSK9f9rym1MditJeFb8+LX/KfRLOcPT9Bb/fAYqGqxpqMNBwNO
	QUKmr4FRq7MDyzYkdeTUsBSI+w3oxPoJm4/u5F8LvsNLx9WQZ3dasYruNWFI8eX/aUMyrUzV/eK
	0xwHgPPfhfPwsDrwqwYTNGzX6FdANiB/MtQjeLxXnscHxE4CZkD+A=
X-Received: by 2002:a05:6a00:1bc8:b0:81f:4529:83a7 with SMTP id d2e1a72fcca58-82d0da47b1fmr5129179b3a.15.1775293767146;
        Sat, 04 Apr 2026 02:09:27 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2694csm8185779b3a.2.2026.04.04.02.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 02:09:26 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Sat,  4 Apr 2026 17:09:27 +0800
Message-ID: <20260404090927.6055-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403155530.64647-1-sj@kernel.org>
References: <20260403155530.64647-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  3 Apr 2026 08:55:29 -0700 SeongJae Park <sj@kernel.org> wrote:

> I recently learned not everyone is interested [1] in sashiko review.  So when
> I sharing sashiko review, I now try to drop recipients who are not necessarily
> interested in the review.  My choices at the moment is the author of the patch,
> maintainers of the subsystem, and the mailing lists of the subsystem.
> 
> So if I was sharing this review, I would dropped stable@ and yanquanmin1@ from
> the Cc list.
> 
> Please consider doing similar when you share sashiko review.
> 
> Everyone including myself is learning how to use sashiko well, so it could be
> confusing.  Sorry about that.  I'm planning to make a guideline for sashiko
> review usage in DAMON subsystem, and update hkml to embed it, hoping that to
> help reducing some of the confusion.

Thank you for the guidance, I will keep this in mind for future Sashiko
review forwards.

> Anyway, seems sashiko found no blockers for this patch.

And thank you very much for reviewing the review! :>

Best regards,
Rui Yan
