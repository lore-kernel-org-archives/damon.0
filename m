Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A744D1786
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668022; cv=none; b=tNrHXKP74/AqCid5ZJpjABcQWr4OOdVTgrIo0V2+HbXGaJYsAIIgZTqKo4Vlz1+W7kne8wCmwnmE1lb0O9UFr2G0Z3U47N239+5Q+teMqohA+uQ0LDiMV9s3NMT/X1Anftgdj1eyA2vlR5WMPgGrMyu+9VEEhQd7Z0v51c/4fUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668022; c=relaxed/simple;
	bh=r9ES15ZQ60J14H0mEKXzOZCuq4aecPRzPtvBjzRMZ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qli188bvYgrXTpJRdQNSZcP4eDs2ND+BFILID2kRyyjNH0bfEvEqycCR4TzhYHpq9LBkS+X5x2ryn0xYVcCxHpYzqovLShG5MG3/NvC1S5ybGrTvOA/KZVr8cPzujCJjcP4jIZpXRnut0TkxnuLVimrkShX2p5cz2wqr1zxOKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhd5/fQ+; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhd5/fQ+"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso981773a12.0
        for <damon@lists.linux.dev>; Thu, 17 Sep 2026 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668020; x=1790272820; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCYa7xbUQUXHtt05AGeI1m7rQB4mKruUeHiavBrEL5w=;
        b=mhd5/fQ+Oqy5IWFrID+FTO33Kn/r9enp/OLa/1lQiHGSd+mwC++LE9uXp7tBfJVEZE
         kPUa9aa3+8fOMQlhYMoyN5DTHOQuyO5QhlWnmwq5DiPuhkgT7jye99tJdBIrBeYPnrbz
         l2vKv8HP29VeCbVDWKx6qAC0dVvDiEm4V6mF9i4OFVTTxdRHso3kkz22V1+e2AscqHw6
         6c+GDC8HfphSaCWmFpYTU/mppKQj54ON+I19leEcG3NAym28twA+razO75c/KssXKpnH
         KE9ksG2ymkQLO6gBy8s8TPlAc/9aqGS8sdO28s8GfI3CVUgtsqEp7kiayD8GGo0EHa8a
         h1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668020; x=1790272820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RCYa7xbUQUXHtt05AGeI1m7rQB4mKruUeHiavBrEL5w=;
        b=kxljSS29BLYK73XYpVn7ZqnJkXHdgdg1QqyJWE8qDgXbbeMAhuyj4Bg+R1i7nIJeXI
         QayAS2rfmRW45QPVdkVB3sq3NsBvIbuiYrXxEag0PU07JzMRQYH5HEx++b3XKvrqLjnB
         WhAVWu2Chg7mvJd562nNlXMB9IjfwrK/dy2vBg17ii3ypyxQVzq7mYNWdwhVQY9u5rBb
         zFD3r87NZqMwJJxIr3eK1C9vQWYV+kz+fh0w2sp23s7+1wSFLWDjGTVjpBpYbyyN5Av+
         BJuT951I26L5+w66z8BD7nTEO4uVBk6C4oSXGGuDlB6mA5pPH3FmExnLzPu6Rgx8gJFd
         GXcw==
X-Forwarded-Encrypted: i=1; AKwUvBx1zHePci8H7cWf960BwwqaAa/B2veHOIQ0VkiAnfibZwX5Y76k1P8gWmtykNJgcMaWVT/JCg==@lists.linux.dev
X-Gm-Message-State: AFuF++lWwv/Iw9T3f8TtEvLAI19v+n1FPDfJkheKnWg2BqTmvqO66ox+
	ApG/BKznDKIe+0xV5HkoHv4OsexKT3wfmts9r7fziX+GAg+X+gfUbznB
X-Gm-Gg: AYBFou08Vp/IQxA/phZBNPRPg63gWGF6jSltCfeEeR5GlZRRjz544vak8Ai0en2me6z
	CLAVHpAlvlQAoQEs+gTDCSV41/PwTSaAA+7zxhtSp0gm8bsuBgI1sJkvSneAbHZ47gUcCb/cb4W
	nQTKhQQBUUebixBl43SHJtD1Xq1zNLPokTHnbE3bqjKUH3D9z37eo/b0DfnpnEoIn9G8NrLoQQA
	vSk7OaQmWvaaLCsAMk3XsYJ+pp4C7MTzQ+HgDV3dfiskwthaCS2w8o5+HwqFSriXQcNoyqc5Ozl
	eSjV1NL1yZ1lMtk9Y7dJheukwsu+ntr+mUnhFduHP5BzYe6cUkTjAzY68x8c7iuJyAhZAti56io
	LqCSiu/WA/rQ/LH6wjDlDNGuMnk+KPgypn9AmOzqatNejl1w/G/OpGk9wzOsz0fa1A1FsDlxRo1
	M7FCqzg5FRwxTmbrhttzaTx07Ms6WMlaHxQgZqs2879uxOmgZEIo19oeT0PTRUDPn05xOKtJXsG
	hKTuHstbpjSDThP/Fc0zLUX0kAbu81VJCSy64UIfz3kWgOYrPNgGzDLeaYAtADXAZwIE7uEYfLh
	uGQMDjV2PPwD+FRGl1rl62rD75ZuEBEtVaHp/9SaCvkCFQ==
X-Received: by 2002:a05:6a21:4782:b0:3dd:85a8:4c58 with SMTP id adf61e73a8af0-3dd85a84d82mr1969849637.31.1789668019933;
        Thu, 17 Sep 2026 11:00:19 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.202.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b1d335sm18580264eec.28.2026.09.17.11.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:00:19 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: reject zero sampling interval
Date: Thu, 17 Sep 2026 18:00:13 +0000
Message-ID: <20260917180013.1279018-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABFDxMHjbQhzvrQmRjo_F9Tf0_zQ20FxaSHFEQN8nfN+VgsF2Q@mail.gmail.com>
References: <CABFDxMHjbQhzvrQmRjo_F9Tf0_zQ20FxaSHFEQN8nfN+VgsF2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sang-Heon, Hi SJ,

> I think SJ already commented on a similar patch. please refer to [1]
>
> [1] https://lore.kernel.org/all/20260722094304.3132750-1-dayou5941@163.com/

Thanks, missed that thread. Same objection applies to mine.

> Can't we keep supporting zero sample interval and fix the warning
> or the real bug instead?

I measured a few floors for kdamond_usleep():

  floor    kdamond CPU (3s)   vs sample_us=5000
  1us      84%                28x
  100us    42%                14x
  1000us   12%                ~3x
  5000us   ~2%                1x (matches control)

5000us is damon_new_ctx()'s own default, and at that floor the spin
is just gone.

Would you rather we just document sample_us=0 as accepted/expected
behavior, or clamp it to that default inside damon_set_attrs()?

Thanks,
Karthikeyan KS
