Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C83175A92
	for <damon@lists.linux.dev>; Thu,  2 Apr 2026 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775108100; cv=none; b=YpAW4guPitGW13wh8KWKiuVEcq5Dm4WrqfVfBWKqIpopeUg07h29UAYVqXB7lSK6iJ5zbvnf3PjKnWgFOVBMBIBuxpIwMEG4ic7+NF52vJUfnarGEBdAXoQ5b+hfC8vrpQ1ICmCQ/BiBXUqexR9Vrak0WWyoiba3QKNfl845i+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775108100; c=relaxed/simple;
	bh=p9Te1X+PVK7NJKtYtTW/rbUihpqGnv7csns6HeIvW3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT0v7IY6VmuIElrQTF+D26M2KDr+G0Scpjd2+q4rCreSj5jZv5E12cKcAzx0JZPym43gkbIZmOAYl3IQgS8odGoksmD3QaKEYLHlz9M6EuuRzjGBD+MyL3cAAeSLbDxrVH8UYrqAkEIlPdmOmnHhnZ0SMcRCaUqPMDAWRy5vi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFcOmqVw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFcOmqVw"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so371794a91.1
        for <damon@lists.linux.dev>; Wed, 01 Apr 2026 22:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775108098; x=1775712898; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAMd7Am3UKqsECdn5Mtl/PD52Ug27urnzze2wv5G+e0=;
        b=oFcOmqVwQqKMUJPuwUJOJ/FTGskQcTobUyBvK7fgWpFAa1f1+zMGcAcqgk1pF7mPg8
         JzCeOMYhve3lxUEN5Mi8hRy3NtD4YIZ8f0rQGpbRPBp0B+sL2v47rfR/Pjmb7q/4GGyi
         hpnajFus5hGFJXl/0+2Tr61ToCyrHg1Wg2TcRWh/xbaBLJBEEAwyXWx6I6kB3nNB8eTH
         2gAhFslq3YeLYWSQjQ23iUWaBeQR3b6ICfmaNjQ8pOKgJVt+xnbjl4sfkRJy6QGbcVzB
         s6PAarJzebv66qfPE5Q+pH22kT5t20df03LC76RtfN1tXIVRH3GmHi6VYTksduC42azV
         8mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775108098; x=1775712898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dAMd7Am3UKqsECdn5Mtl/PD52Ug27urnzze2wv5G+e0=;
        b=mfgVhWIr+5+xNY3eIjbHHTWOT99QWuP7YBhs+EJM12bQgxQ503a0KZg8AdNu+Y1FM1
         /qdkur++GUuABgXA6zDFNAqAIpncEZ8mFvQLWjH+wYxf4lO+4dfBJ48jOojgxlQplDwB
         4gLKJQLmH4IeGqEEdyOa8lU9UTaxi5bwkRstJrqzbFAF+lUwrhythMXZBkeUzxe11qd2
         NNbgEJDmnzJT4akjd+wV+TnuenZ7fn5BAwPyli42BFYulHUFjDFWyKrH+dIJaMMPyCuE
         3gMVbKYMgBO2Hi86Simpm/emkPiJQZeUZbkCxFv4VGWJNNP8ls1nFK8Vfw4UM7rI8c/E
         AXBA==
X-Forwarded-Encrypted: i=1; AJvYcCVmEXrhT+83ffNpuLgAbC+aSnPUtrYled7rb63SjXX8B7r8rRMOjP9Q2CZzYkM2RzhIJnkugA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz5RPOOLVQmrhBG7QGT3gRdg+N45uQlU0XukqpxMRNw/TbdyTF
	tdBwHbxErBgGI4UdmGLxDjTfwOmHMe0qnRweQqlSULZ83Ol+Q/wIq080
X-Gm-Gg: AeBDieve2vp+SUUwO+ZxYtEVQR/W6PNXAzVJYFRXDtkcW3hqut/goTvnSuTrDdZCuOj
	ci7MkYWq1LTK7T9qk0L+HT136ypHad83wXJJmPyaYYZ7p6GuMiVg5lTBbLmBy5hqP0fl10LX2rJ
	cSQHFk3xTbWBrK6AiDxsDhAt/a58IdIdVRCAV47k7LGvBHx1sbeUARcpXRTZ2t/Kmb3I/p9sFCg
	QRxvAYysTrzipiIw2Gq676n+ZP90a0OcytmtwtVqlG3J5tp1jdyp0dnU85YbOAdNqwCvPJuNTUZ
	wm3LTB22jLEH2NPYFys70Kq0vdjRDdtdP97Cp7ukxX0r3LiGI0p5gU3UcDyA9TcVD31JOUv/n+f
	Fr1iwPIpAikl64YAAsHq4WmeEnTIGtQLwcjSxE17QDu87hUdCDakQtipPYYINlltuWvRp23FFqb
	7627ccVVBXPou8gnKJU0hmkSm/NDzE5Hm1fOEQDEVEJKfHVlZcZL4T5ryrCvzSrQ==
X-Received: by 2002:a17:903:1250:b0:2b0:60f1:de58 with SMTP id d9443c01a7336-2b275dc23b8mr19612315ad.45.1775108098179;
        Wed, 01 Apr 2026 22:34:58 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm15917055ad.26.2026.04.01.22.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:34:57 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Thu,  2 Apr 2026 13:34:58 +0800
Message-ID: <20260402053458.26524-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401154119.67874-1-sj@kernel.org>
References: <20260401154119.67874-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

On Wed,  1 Apr 2026 08:41:18 -0700 SeongJae Park <sj@kernel.org> wrote:

> [...]
> What about checking if damon_call() and damon_commit_ctx() failures via therir
> return value?  It seems damon_call() fails only when kdamond goes to the
> termination path.  damon_commit_ctx() failure always causes the kdamond be
> terminated.  So if I didn't miss something that could be a path forward.  What
> do you think?

Thank you for the suggestion. I looked into the code and I think
focusing on damon_commit_ctx() failures makes sense.

Specifically, damon_call() is only used in the damon_{lru_sort, reclaim}
_enabled_store() path, which doesn't trigger unexpected termination. The
main risk comes from 'commit_inputs', which calls damon_{lru_sort,
reclaim}_apply_parameters() . When damon_commit_ctx() fails there, it
reliably indicates that kdamond is terminating.

My plan is to add the error check directly in apply_parameters(), right
after damon_commit_ctx():

    err = damon_commit_ctx(ctx, param_ctx);
    if (err) {
        enabled = false;
        kdamond_pid = -1;
    }

This covers the reproducible case (addr_unit=3 + commit_inputs=Y).

For truly unexpected termination (e.g., memory allocation failure inside
kdamond), I'm considering a fallback mechanism in enabled_store():

- When the user writes 'N' to 'enabled', if damon_stop() fails but
  kdamond is actually terminated, we reset enabled and kdamond_pid.

- When the user writes 'Y' to 'enabled', if enabled is already 'Y' but
  kdamond is terminated, we treat this as a restart request.

This way, even if kdamond terminates unexpectedly, the next user
interaction will recover the state automatically.

Does this approach sound reasonable?

Best regards,
Rui Yan
