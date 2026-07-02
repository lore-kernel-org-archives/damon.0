Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7103168E6
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975781; cv=none; b=YwGvROfES+Pqh5ZSlLicY752uPUmf4fnvAnp0OjrrQ4LiETLiel7CiZ4ZMHHzJ1NcvWx+VgFDYEmZ011doD8SrHtpcpFNR9qfY5jR+Fcaz55WXzapD1jt1JJ7TurM6Wmj4nefhl1eTkYcb3xV6ybLQ0aBehW4wYuRAdGgBVVKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975781; c=relaxed/simple;
	bh=7+7soT+TCrSVIA+ZgeYOhCKYh3ZYEoJSNWdBgMBvfB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+MFh05ZMRbD1tWQAVtwq8fDVwciGT1xK8zYNGYjp9wf2wSKK1i9a2eNzaXvJGMg1fRlQIMtAtdxwiMvaqvE/vV3oQp24woZ35zCgNTLfPDCAMVhyRZ4hWJeZOf+0VT2F3pXbYml0vIhfb+Rzj4fAFjHov6IaFvH4JRlUIf9pzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWg2hBP7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWg2hBP7"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37fb17e1435so943182a91.1
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782975779; x=1783580579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+7soT+TCrSVIA+ZgeYOhCKYh3ZYEoJSNWdBgMBvfB0=;
        b=mWg2hBP7diwkKtNQIPvZElnwNWAKFMDNssz79huvJneJnlXqwhCH17jGInpOQAcgNf
         Ac8Xidfax/bimJ9E/OQBdzMrKs+A4a3IwOtMM357CGq/G2aHqpEbsyFZe+ikT4eLwxLF
         OYp7BdkG9fS5b+rE9f5s00ma9dHvdAMft9fSzHbcrpJqT3ByInlU2R2+P9zZ1jZPUPzg
         78QUxBQWzX3H2b0XgvDZbm+oXVUvfUzuIa+sp3qMppkxw06wDEph4WMJzV0CAWBoUxOW
         MxescccY+dlenDSsVIh7uOEx9dJs48ntjlzN6Cb0uSF3dLKYdZe87DnGRyxoSkj3+foA
         Ufpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782975779; x=1783580579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7+7soT+TCrSVIA+ZgeYOhCKYh3ZYEoJSNWdBgMBvfB0=;
        b=i/CbWVt8LenychzZSHidy1JU6WpDG+LL8xuP1xipw1GTrIuf4OPfwyumVTF1dmlhfW
         lD7YWj7mJHhjsMyyMppKBVDcpLmDNCxpsQ8LBP8u8PU1psn260BAvYzzS/Q9yf22TOqx
         Hb8KcBltE1OcQ/T8/AAEdPmyvGv8ymOY/rDsmwy4qU/+7kZr2mDSsvY+iYNNeJ0fkL9q
         enT41w66P7lSiG0718EKG6BvX/cUTXRNrTXaft0OqKxQ9Iklv2WeRH9Ezd+hHRB7AT7g
         4455nZ3wZ19q5xcu2jRWZCI5MqhRt9vBR6/LczYr0v0F69ReomVOqTGYdG5rwCB4QTcK
         YAyg==
X-Gm-Message-State: AOJu0YwtDNAzbvtOE4yItesboy23vhWDOFUJUx2Olg1Zx7wnnRleJ77X
	Iuj4qglzGTKkv+Sl8AbXlIZUMMm9Y7eSXy982tYVUErrVl016VmyTRKt
X-Gm-Gg: AfdE7clxMKPa9Rv2Ad1Tm5uQOU0jT7sPoKYuorvrIFWmqFjXf9Bs/6pK6EZ6YUH67c7
	XAk1NoDkzgyxg41dIN+WSw7vZDqIdtBNhFIXGWO05OL27VF0PgOwaKbFyMW6ksTQDl+qP5Fv52J
	Vd+mnjpB/kHKHYFBLIW4VxBHd923gw5HTrQB+fHUYz0PfbOcg/TkcTG0Yeuvvrkhigz3EKsVFLa
	Nr6y+5wI/wXds9qNsz3B1RVP1W63Eth31Udw3n3RFWSwpQwt5280UWcFz5Y83QyOOMImQMrPENR
	A2ILA1LPvklqYo+ypLybXjB93y87VwpKVwuFia+YX3YGNmL+84aduhRtzkSxHXu5avKx5MLeelk
	E5cAn8RpyNzNZ8f38nLdwtFCqNSJvt80AfyGyb/SYCe0weDO9JmmcHeMjwH+JKuEMrV95pjo7h8
	eeNQ==
X-Received: by 2002:a17:90b:380f:b0:37f:eb45:e058 with SMTP id 98e67ed59e1d1-380aa1c7d63mr4870185a91.19.1782975778910;
        Thu, 02 Jul 2026 00:02:58 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84405sm7910815eec.17.2026.07.02.00.02.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Jul 2026 00:02:58 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn
Subject: Re: [PATCH v2 0/5] mm/damon: add mTHP collapse and split actions
Date: Thu,  2 Jul 2026 15:02:51 +0800
Message-ID: <20260702070251.70882-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701135220.93697-1-sj@kernel.org>
References: <20260701135220.93697-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Lian <lianux.mm@gmail.com>

Hi SJ,

Thank you for correcting my misunderstanding of the versioning rules.
This was indeed a mistake on my part, and I apologize for the confusion.

I did not intend to claim that this series is ready to be merged as-is in its current state.
I fully expected to send this iteration as an "RFC v2" to continue our high-level architectural
discussion, especially given the major structural pivots we made from v1
(dropping the debugfs pipeline and shifting the telemetry to user space).
I mistakenly incremented the version number to [PATCH v2] while
prematurely dropping the RFC tag.

Since my true intention is to gather feedback on this new user-space control
plane approach before any final merge integration, I would like to fix this immediately.

I will re-send this exact series right away with the correct tag:
[RFC PATCH v2 0/5], following the versioning pipeline you suggested.

Please hold off on reviewing this "PATCH v2" thread;
I will get the proper "RFC v2" into your inbox in a moment.

Thanks again for guiding me through the community conventions!

Best regards,
Wang Lian
