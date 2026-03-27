Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5237FF55
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593930; cv=none; b=t5tYd66cGWZssnk9SxU0EtbRUKzU+TZrackcWXb3m4xYXV1f7LgH6jgGXJE9DAJipUit8QlnQGZJBuz/qjnEJbvwLnMUEy/rn3MtMf/97okRfLtVKcyC0+bLAcZVBP86PIb3nyPFJXB43eOnL0pcVybL7uqZugm923Yqfg5Ul0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593930; c=relaxed/simple;
	bh=BWG+nPPsRXK+2ca7kaKtxwG7BnAy9EQr3/f8t6YfWvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOT02Y23RYTx2S2OspW/ZR1l33GuzvYOm6FP64fapEtXuX2x9D6i/GCnAaUHrNQ1X+pVb7GsAWgbEImuH7YH5H5mZBRf1mEiD6JGwn1fxpW1QD8AvG/JoI8O5cR6UUo03HmwP9tMjuneUBr/Pr7kXlIa4aCupqOKseLLitU914Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNtw2RSA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNtw2RSA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c6e2355739dso773087a12.2
        for <damon@lists.linux.dev>; Thu, 26 Mar 2026 23:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774593920; x=1775198720; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CZF18FR/wzFPTRFS//7fB0vxgLV+gO2BJewVZGH+2s=;
        b=nNtw2RSA3/uBnJpM0tz7x3nViRO9StLjFr3w8bYQrDFjHYq9fuNIzvNtwim4CtGodA
         WkuVuU6gUry4CSfl3fAgu+dizPEUKv0GtJMtMe0CEYTMRjCfs9/i6hGZThRyCgYSDrmM
         6nda4Pz/SBmiTX4FXKmUTV385wYQZ46st4e2mYxQB7Gl1muqyIMOI1aVVuxYX659jF7s
         KP5of9ud9s07lIbZvVLXdcpyB/68YWlhAuF9LQIbqJqdYJm9QWSru1l5v68Fc4t0EFdo
         ylDo3rk8rSVX4yw77zN6xz8jvWspRVTo9RczXTaS9oULnrJRTEmhA0da3YIr60EYEHOg
         cCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593920; x=1775198720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9CZF18FR/wzFPTRFS//7fB0vxgLV+gO2BJewVZGH+2s=;
        b=XWB7QHLu6SAvjdQIhRzwZbWP0GhMys/DuHt7tyaLwrCQMIh7cndUy0oxFwhT/4s1Yy
         08YOOzN5IQ+HfJHGTUeYY/TBXjyGddAftVMmR6gqQkfrHUEQf2k7/wfzA6zlRCO61U4a
         OdRYRUdFdAAwC8xVOLt+4gauFUL2HY7NWwAwae1orqS7we12Cp2NyNJFMJxOWzfaHH/t
         2ETSs+lGsSGFqkL59NRLkEk6YMULOT06TyCq/sWfjn8JSkzOblbDGcM8v5624hPuvk/k
         vKziidVFUcVNhXxkBLYDcYNf6hdtvjh2EmSpHxVIo60CUuYNqPSCAOudT/VJgN6i2ghm
         v1CQ==
X-Gm-Message-State: AOJu0YxclUQa23k5g64cf6WFgpggXfBJbq9+VHG+wM/aOFkOdjoDJe+z
	WbpTZvMLunNjJ7f0QjGk/B16sU8rfcxJ5qVfrVWiPr4aTElXOjEFJkkF
X-Gm-Gg: ATEYQzyL8VF1AhCvyqfprphHfp7TAN+jpTG8AOW3jTRtHslwZp3KksgXvJti085DpOq
	18Pfhwf+UZBsPBN4TkOPFX9TM/cL1z0r2ElIGkB5OrqRw2A6vhujMpYZ36koZgDmpjWhzYPPXd7
	o8XJGzADKhNQhG9ybH1mo67qP32urXkzs5OC8yb/NWRE1lK6MYMKoqZQRXD45l/29btojkKOLRl
	4+NX6D2bn5QpEux9/wN2tz8wW9yqI8A+fvI8FSZyvJ3FSTnpg7d7DPrA9aG7j5YwzSAHtJWLNDP
	rY/TXl4RCgCXxvQlQPyGoeBeEuEU3suqvpm7zL3kvfBEtqFvOqjjzdqJHMmurncksytO+a6+t4B
	sV67YACR0LKsAkQyPYfarOuK+JfgILT+K58GaHJN5kczTshYgXeQxPzcmnjQPcFLcObc0o42rfX
	7ppDy1tpD+/DRzxoqHjTYiPCdso2s=
X-Received: by 2002:a17:902:fc47:b0:2b0:6e60:958e with SMTP id d9443c01a7336-2b0cdc1ed78mr15837445ad.7.1774593920106;
        Thu, 26 Mar 2026 23:45:20 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm50595435ad.2.2026.03.26.23.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:45:19 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Fri, 27 Mar 2026 14:45:17 +0800
Message-ID: <20260327064517.68131-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327062627.66426-1-aethernet65535@gmail.com>
References: <20260327062627.66426-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

While testing, I noticed that when damon_commit_ctx() returns -EINVAL
due to an invalid 'addr_unit', the kdamond stops running. I recall you
mentioned [1] that the kdamond should only stop for "internal error":

"
I found an issue in the current behavior, and just posted a fix.  Assuming the
fix is merged, the behavior will again be changed.  So, please do this only
after the fix is merged or completely abandoned.

If the fix is merged, the changed behavior will be something like,

"It will continue running with old valid parameters if the parameters are
wrong.  It will stop running if the parameters update was unable to be
completed due to internal error."
"

Is this termination behavior expected for this case?

[1] https://lore.kernel.org/20260319151528.86490-1-sj@kernel.org

Best regards,
Rui Yan
