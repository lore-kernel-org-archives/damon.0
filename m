Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624D9370ADF
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788680641; cv=none; b=Zkb7wthXHvEKHysKVUipFZqdPXwMW1KjoYIYuQ77Q5J4wlPZP/52jQhyjUINNESaUIQy2EIxRh3u90TMbEMmkg3zCZ6Qo/P8fFlZcsHw+aFbCZVbYoYTI/FYjoqhpHS2QP1oy5m/jTbAo2njPjN1UkWgU05eyr4Q0oIISSIaak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788680641; c=relaxed/simple;
	bh=ZqwsPVgyFJv+SEFp+qmO1QV7HoaJkZ3URYG58eamnw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlZ2ksMbyvRusZqvygOvD+nMcsrgfJ1nzFplY90351Lx46+wt0lkSJ+e9Kri5fF2ARPtUQwYNYohQ+VC+yvvzGNfulSwV8u+v8qKnVWw8/NCsMWQC7k5ZmPoac0lNdX2IyQijq5XcZh/fwE0TgqCiAAAF1Es9OUMlTw7xErrhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEPO6rov; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEPO6rov"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so2778411a12.0
        for <damon@lists.linux.dev>; Sun, 06 Sep 2026 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788680640; x=1789285440; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J1TkmgQ9nfGG4KDD3QAFdk1UIWjxj5+qevfPzhbM+VI=;
        b=bEPO6rovLOCeMJMsjXrx3XWI3eaQEuVwC11mr2b91fz9srskV/QX5BVvs5QFB8tXra
         yZ+LAgN+TPyuw23Ig3G6aCbQeh4F5NvZX0PY5wlwTaBK+0xuzOQ53a8O7kR7idncDjdb
         ZSen0CArNShtLBS1TF18UUTDSbUXDxVpLxGjgqmeM3cLY9L/9XhmwnRqxUS++rk0utJj
         RBPOHMl+VS6rEX1IUpw0VZR4LxZdMoGCjBeq6mpZP8fAvpu47VjrShatiM5HRc7eSsXM
         URnnKRkyaYwRBGTXEMtpmWIuBhAgMaSdtbvXA0/anWtduRs5PolWkhypZ/J/+c33Kfk/
         USBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788680640; x=1789285440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J1TkmgQ9nfGG4KDD3QAFdk1UIWjxj5+qevfPzhbM+VI=;
        b=eevmHoiT5FDccViv0M+d4segJ1GrRRJ0YoF2p3eAws0So2uwqniqiPW4+R7cOGFg02
         0MnNHXNmIyrErcwZym69DjoLs3KtMdadEXAyiSfJwWfw1zLToMVpGYlYH5ZCoJPcj6VM
         CmJGs43fmyYoqaBDE+f2IbFHe8r/zwPPz/DxY+0lCEem2j40plOsyUx506mkzwSHEbY2
         VCpEUfsZb2gCG2AJm9ZfAI5+MsaQ/HWR8nxpS+BrXB3wbZktT6LzDXQe/rmZ28PoruPq
         zOJw8Ejvz5Nfr2IsurugWF1xO6GXWID01wDU8BlNDZG0vyCCAcW61Mu+KWgqW6zafMwY
         FN8w==
X-Gm-Message-State: AFuF++nl8I7s12cn7itCzCSTg3lptaaI1uyy3r4iGBWXJJDdzJUz3dCY
	YSG+bJZio6QrUQinSa2TN/+DeVmVsXCLhdxdh7SSQAqSP1yuRYzHw9rv
X-Gm-Gg: AYBFou1FmD/XboiZJjNpwF148PDARWDwIm8rj6ez0+hCVp7rENhM7aMEHoCgLHZU90O
	OQa8eGlIHyKia/3H5NTvMMsRtkSpqpyXrO4d/ORej9sCrI9aILUd2xo/5gNyIGeufAwpQqX1LtS
	jh0ViU7AWoCNex8K1ibDx3kRjWqMFnYFOEhO1xDAsbCnOA0T/qs5BHrZ3GdFeNidWGne7sAF+zW
	1C8J8MXHGWhnRB2jCjtPJY5wqSewVhscVAoJKcp0eUtBw5k03k/CuhU1ho7kdlWVaKLxzcnATiw
	ASqnNrnUlS2b0xfGKqWYccnHSWCzGwMQv5CW2zWDW9D3uJMzOmn29OhjI+8W8AFiFZEDx9ixMd+
	k66SzYDfBU4y5WXqpvcmKHNR25UWS9pAjcgDMHx/9cMFNjIRZb/GL2rOeAyic4cghr3h2hVfT2P
	Y+SMQbcBFjJ0dqmAInNSqCyx10Ki0ZzmoBrO1YAFDGUB7FFj1aEc6xssgpasWQMv+FWIXcyB0=
X-Received: by 2002:a05:6a21:8cc4:b0:3d3:adad:f171 with SMTP id adf61e73a8af0-3da3a081a02mr26964214637.19.1788680639701;
        Sun, 06 Sep 2026 00:43:59 -0700 (PDT)
Received: from localhost.localdomain ([104.28.222.46])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm16288172c88.3.2026.09.06.00.43.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 00:43:59 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: Re: Roadmap for extending DAMON beyond pte-accessed bit
Date: Sun,  6 Sep 2026 15:43:21 +0800
Message-ID: <20260906074341.29976-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905171537.84217-1-sj@kernel.org>
References: <20260525225208.1179-1-sj@kernel.org> <20260905171537.84217-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  5 Sep 2026 10:15:36 -0700 SJ Park <sj@kernel.org> wrote:

> Therefore, I believe we can consider milestone 1 nearly done.
> [...] 
> So I believe it is the time to start milestone 2.

Hi SJ,

Thanks for the roadmap update.  This direction makes sense to me.

I plan to align the Arm SPE extension with the common
damon_report_access()/data-attribute infrastructure and coordinate it with
the AMD IBS work, rather than developing a separate interface.  I will follow
the upcoming patches and would be happy to help review and test the common
infrastructure and the IBS series.  I will also track the remaining work
needed to bring the SPE support upstream.

I would also be happy to take on some related implementation work.  For my
earlier DAMOS_SPLIT work, I am now preparing v4 with this direction in mind.
We are designing representative workloads, collecting data, and exploring a
few design options before deciding the exact shape of the next revision.

Thanks,
Lian
