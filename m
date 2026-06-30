Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965122424C
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829552; cv=none; b=csshClJ7I3QqsFGBJ+h7nefDkgQwxvPko/w4qboMeeCBcaMfV+BankJ60sJpv9jlyCV40iYDV0WyurZhouQkGrsNS9ezUfAabNp4uPdl2JSIuJOZ9oRwqDDZ3tx8MrMI4sYjS2FoaoKIqDkWdcLEhRAcFPCFTcV1Qi55oJOPeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829552; c=relaxed/simple;
	bh=LyaBlvtzLg3/D7avMailtRtNnHXXt7CQFthCD76A1P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASOhh+nhrGb/Q6ptcjgDypXDEEkJ4kT5vzZUg7DWwVEce/8mu8xU1c+Uj26rWmnfXu/FMO0PHb8VHly3DtFjbiBWv15x/53iEgcTf2iyaHtj4eaGPSZtNJ3ltFOrS2qSE/jDLh75+31CpMmBzHdPn+AeQyM+ahNDYdsSMEVu04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4K7FyS2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4K7FyS2"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb8870485so1913571e87.2
        for <damon@lists.linux.dev>; Tue, 30 Jun 2026 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782829549; x=1783434349; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyaBlvtzLg3/D7avMailtRtNnHXXt7CQFthCD76A1P8=;
        b=q4K7FyS2XB+QaJcZBRoP4PHgVqHzIHqxDUEFqXPOICqa1p/Naw72EKeIBp9PTk6tdd
         rihJljA2SJrT41kmOvmcUUcAdQh3HGRQldlR0I1ibkKaxMMxhFB/t8/HG+LULut1FpNG
         F1i66M3b9JYRBuXbuxOZ4ASKKub+7h3enW4Z3VXNiy/nOcFE73ALjY2h2FEbGRoXr1To
         gaKcXbKNd8hP0EY52di+qmFjXrfeLStM1KOzZw/tk5D6/THtbhGeAKIUlg2KOZmf8HH1
         6KeG5iVunpI9+ucmAIWLg8d9xYANIF/38FhaQvGgNWiShMDjvV4sBQEF2mUIRAkH1I1I
         XAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782829549; x=1783434349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LyaBlvtzLg3/D7avMailtRtNnHXXt7CQFthCD76A1P8=;
        b=d7cN0mfqe8ECRWnIwrWjlJNCTHs+5Lpe2cwe9MwTAQ+IIJBnkILExSCOYKI0nYA0hF
         U59Wb7iZVYket4KL4tgzARXx4eaVyVKe0heFoVVq712qwg4jhP/cgyGuoQX87qdP+oq1
         MObs/gsTjcPQO6Bxo9mE0Y4KTqjh1yB88Hkz1Zxvzz5LPqiM6LqgLiVKkcuMD20HaTLO
         zw8u6OpjubGjLcHQ0uwiwj7kv0HIhC0Iy5qV5dcKmqwqIh2kwvn8NsWln+W3lxME5zPI
         5RhlugjRB7ULz61WeBBNfahBUF9uYwNQ/QBXDEGqy8doiLFp0ToAqdCYi/D7+NB8+OG8
         HBsw==
X-Gm-Message-State: AOJu0Ywnpr774R+zLuP8uYzPqGX3Pdedkq6m3CGXG0S/6e0C7Y0HtcwQ
	l/jOnCeAbUEWXU3n/cnJzilF9HXyoMxv8red22iCbCVxkVF3e5l//qC7
X-Gm-Gg: AfdE7clNCV56flawpe9yN6zRaJC4SLvE/WpErdjZq9r/xRMAgNgleYfGM+PpR08wJGj
	7Lmtk+VcyMiDg185gbxq6j79LpyEYyW4qfCVmqBQpLKAVM7nHZeYbH/v6pbsgYJzRjVsOmLcWaf
	MAxmgrYfc2+Pik1cEJEl2njaZiv9aSgfyMAKIZXSsFpT5OwjRUMVOlviSQD/HBJOpOKWqGG0Ufw
	nIhX0ipnua2U9QFb1KfXgv4AIz1glIVmuJXXGTp4DBHRFA09RhwS8rCpUQgJxHS8jE8PGLRkqEb
	JWJCzv1ZTqt1TuzzwmIQLHfkHh5dTfXF9Ipysvz031TPOhN35ywtUrBKp7LLOmgV0/T90N9ADAi
	RAsvqAiSI0ugEJO8w4WUPzuvvAJVsgZmP6Hxrx27hffO9sPTn09QxOPC+JbNru6/JP7x78qFKt+
	TZIa67djY79KwcoN1EvSmnK39WPi50aE0uW+215vGlQc/zr2xNtIqHppukZ3Lm8PeyNmLw8Ek+i
	HQ1NfWG7v+nC/sn/Q==
X-Received: by 2002:a05:6512:8050:b0:5aa:6fff:c3e3 with SMTP id 2adb3069b0e04-5aebdbc6e03mr726250e87.33.1782829548247;
        Tue, 30 Jun 2026 07:25:48 -0700 (PDT)
Received: from debian.localdomain (95-25-158-125.broadband.corbina.ru. [95.25.158.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aebe4985eesm629795e87.46.2026.06.30.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:25:47 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: remove redundant RCU lock
Date: Tue, 30 Jun 2026 17:25:22 +0300
Message-ID: <20260630102400.reply-damon@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629165349.4260-1-igorpetindev@gmail.com>
References: <20260629165349.4260-1-igorpetindev@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Thanks for the reply and the pointers!
Regarding the issue Sashiko AI flagged - I dug into damon/vaddr.c, and I think it's a real bug, but it's isolated to __damon_va_three_regions().
damon_va_walk_page_range() is fine here, since lock_vma_under_rcu() handles stability on its own. __damon_va_three_regions() is the problematic one: right after mmap_read_lock(mm) is taken in the caller, it sets up a VMA_ITERATOR and runs for_each_vma(). But mmap_read_lock doesn't stop the OOM reaper from running concurrently, setting MMF_UNSTABLE, and leaving empty markers in the maple tree. Walking the tree in that state without a check_stable_address_space(mm) call could lead to a NULL pointer dereference.
Since this looks like a separate issue, I'll prepare a dedicated fix and send it as its own patch thread, so it doesn't hold up the current cleanup. Let me know if that approach works for you.

Thanks,
Igor
