Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CF42900D
	for <damon@lists.linux.dev>; Fri, 14 Aug 2026 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697223; cv=none; b=NOZDSBJusHTz9E5hsJEuiet8zoxmDueS5SQYQJecowfuwJgBZs02wuwM5nxrOgxy51RIbaP7yIiCDz0dd5pf5g3P1epBGyPEFc83Nrb+e6r3bkxg5KPZeXFnaDIOZptkwruecwf85twPuJzF3IYrTqD3zr3pswIRq41+t0nIRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697223; c=relaxed/simple;
	bh=Hc5FrKNIRlcoh6Xeb8icE5pbn+7QdVqU/pC3LMPPrN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE0KHYVss9q4epABNYewSivCyyxYSGbu3UZ3VOS2AOvTlihSfXDWTFtf9WMaLO7rsyMQtORvAx2ziy5fPo6+OUI5PfH/y1Bd9ARJ2cjzNkRxSaTGCUAsz/VQrKxU6SpfxiFkT7cR1H8PoCO5PCEoIMtvAdOSw8bQBhGmO9txq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzijGx5H; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzijGx5H"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so653297a12.3
        for <damon@lists.linux.dev>; Fri, 14 Aug 2026 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786697221; x=1787302021; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDqjoiUvHjoApvKi+JnXgMQwtgW5BY8TIp93JdyJukM=;
        b=YzijGx5HhP/mH8Ay74sqUwqf1AHi4MeeN3Ox0VPK1QuvqKjvCdhYl/xC6d7YNF+95/
         OFZwNnX7kAJCeXgMqknJYp3jssqDbnhDR4QaPN/M8nPJ2hsYbzngMsmrY/KR+pbake6s
         ia5klcL5wknVd8N8PrbR7Zqem2g6xYZEC1wzdmxLHeAFIiOUG3B6c4+7DE2bgs2JzPPR
         ip/vzzSJTw8hAx+DNHThY88ELqeyzj3KnYuKQ29qLZzHQq26Ce/9KWelUfceQIsNWc/Q
         4VyWbPXaSHwvSe6RCs4hTIw7OIlMy/2r+iQQNaXpMxgY1zG18q1zcJ+7t1LG5g/2quLS
         g1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786697221; x=1787302021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDqjoiUvHjoApvKi+JnXgMQwtgW5BY8TIp93JdyJukM=;
        b=ZrSI4bH3qpPKewuJHesO3o/FSQukiBteQqVB3XQswDtWrZz4HpDh5ofiXxmh8DDgWx
         tk4FvPxAnGHm4fnDP7jk7tZr2aEya2K5ICNhvJ2rbx9ETGx8Up3qWiH1ft/aiIAenc/1
         MeeFMYk+Kwak/D88GoJDDrtRMq9mu+l5uDqfiQht4QB0rKkXmYRq+wC1UemWe+Rm7VkC
         X3xpG+pIpO/5pkP2jmTPKrfYKZhKeYjhSBlbU0iOneXqCQKBXG99byDaVfgQW79EY30P
         YBS6u9e0G7+6jSRdvv+H+AxsZz9vvq04qbiVM24W67WMapi+aI+vIpCr8dJH0O+XXmDV
         MV2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp9ZjtqMUGDhGW4cQmb8SX5rhs5vvGeBrFARaF3lJtuJjTMNVMkXBCvaUAuzZQTzY5bHfxM1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQEPxwDU54qVoH59BJyrxdfPGbT283SQGdMjah75XHKVl9c7HG
	3skTDBgmjgoTvyfEBEE1nF2k89l1aqRt6NptyCmSlk9rrK9u+KfZW91WJh81gw6c
X-Gm-Gg: AR+sD105aUU1XFtfWJKU/uH6tIYEucXAGgJxrH+DOgAzAG7y3ud2LTIpUgTTnNLYUxJ
	FbsMqY2SoCWwAhhgru+jLlz4YRGRZRUMDX5pVf2gRBti3QCasS7aJ8dOonfMx/a/8OSOc2Te/Eg
	+OeDl9LYi6oHYMcwGB2UzIlwaH2mQ6hoMzjD14yKgBg8BdmRRgDEtsxt5uvMCzONdA+kibIGtKz
	Za3/ak+VRmKLLyxmGTzspuo/P13rTQHaFIwFlKsxs5XsMulfK4cT4rb+A/NlMnA8FVoqDni0jbe
	M9FrWT6p0IOxy6iA06fw73PyFXJmILKnvmfAQGMDkjDfAcyjAw0nMVvcLpkNOo9Iyo0acIqXN3C
	Qp6X/KgkmU3z+N5s30sYVAU7X0Ftn4QNtS0N65i9Rzeh6T33aq/8ZiS7LkPORND4FF2PA6bjKNt
	a1YHbA0pn4Z7KiyOYXakwMyKSymgSwgIFOpbMtnlpUskxX+h2VKCnrqclvCJeoiM0ZfOusPaMeU
	v88V621886cf+2v
X-Received: by 2002:a05:6a21:3384:b0:3c3:64cb:9b99 with SMTP id adf61e73a8af0-3cc719c78e4mr5591931637.6.1786697221422;
        Fri, 14 Aug 2026 01:47:01 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2fe8f1sm2058373eec.23.2026.08.14.01.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:47:01 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC/Discussion] mm/damon: Helping with alternative for watermarks
Date: Fri, 14 Aug 2026 16:47:10 +0800
Message-ID: <20260814084710.39955-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Regarding the alternative superior feature to replace watermarks [1], I
am very interested in helping you design and/or implement it.

To share my context: I am primarily using DAMON_RECLAIM on my personal
laptop.  During my usage, I found that using the free memory rate
(MemFree) as the default watermark metric is highly problematic for
modern Linux environments, because the kernel aggressively uses free
memory for page cache.  Therefore, I compiled a custom kernel that
supports monitoring the available memory rate (MemAvailable).  Since I
understand that the current watermark mechanism is not planned for
long-term extension, I refrained from proposing improvements to it, and
instead focused on understanding why that direction is limited.

I am very interested in understanding the design constraints behind
deprecating watermarks.  From my current perspective, watermarks have
these drawbacks as a run/stop mechanism:

- Mismatch between local monitoring and global triggers: When monitoring
  a specific target (e.g., via VADDR), the scheme's run/stop decision is
  currently tied to global system watermarks.  It is impossible to
  determine whether to run/stop the scheme based solely on that specific
  target's memory usage.  Therefore, the new mechanism might need to
  allow user-space to pause/resume schemes based on custom, target-aware
  metrics.

- Lack of diverse metrics: Watermarks currently lack support for metrics
  like PSI or inactive/active memory ratio, even though such metrics
  might be better suited for DAMOS auto-tuning goals.

However, I realize these features could probably be achieved by simply
improving the current watermarks.  Most of the drawbacks I can think of
are basically about "not enough metrics/customizability".

I assume there is a deeper architectural reason why you consider this
direction unsuitable for long-term evolution.  If you could share a bit
about those constraints, I would be able to think about the new
mechanism in the right direction, rather than approaching it from my own
assumptions.

My need for a more accurate trigger metric (like MemAvailable) and
always-on monitoring is exactly why I want to help build the new
mechanism.  I prefer to invest my time in the future architecture rather
than adding features to a mechanism that is about to be deprecated.

If you are open to this, I would be happy to start by reviewing the
design direction you have in mind, and then help with implementation or
testing where it is feasible for me to contribute meaningfully.

[1] https://lore.kernel.org/damon/20260808000739.1308-1-sj@kernel.org

Best regards,
Rui Yan
