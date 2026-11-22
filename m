Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368088;
	b=F+tAPnL+cw+GR1T/bwZje9meR9kjZcPonODH8GL329abQZJjyB4U7RWphQJKtgzwBukA
	 PCEwKrPZ2YKZBrQNxsHVWPOfcwhn8rdkIRfEsCQo2ZKw8+15/FxNze+T3RSixZXoU/uCP
	 rcWUBc0mI+ZNt/tR1yS9MsDQzwt3C8gE/AmbCEUQw1ExNBpO/NgkLOH73VMfGTpCl66gH
	 VOWpEhKQnPxPtqu2vdQWTo+Lm5TGMBq8SAl7AesWIMP/K513EExeAFRyXxG11FvEe8Tqc
	 zxgZSXUv7+b+8VqK/DpvLdNYaBdr5gQsuK5I16D6616H/ZtJvexXDNrGL/zivy0ODLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368088;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qactUoyjpgY5pptL4OazGhQ4h7pIDgNLQg3L1qeBdho=;
	b=5LhaYV5pjulYjIeLNbqd0kFfSunPrtvNvvA5R6Pazn37GjJzyt7/gusQ6y9NOzbh61al
	 FlwxD471bhbFbuxdpaIPEFTj1neX2gLzz2fsyFmg5Wr8qJAwYi4Q7iacdGIsukceGkqGb
	 nzkjeD3TcsV3KOXgnEELSjF/jnBotbNPJ1CneNVUPyCTSOqZhWSvr6r+mvH2WbqCBjIbS
	 ajedGWHKGj288ijOgwEMiMAiJ1SNA2O+6c/Oj1tgDDwjTobUxyR/YuBtH2qSXrlq4j4/A
	 mEJ+ZAZYh8sJX6gtZqOxqS9Mnab2fppKBznNPz/o58k+hTDkd0fkJOZ16ml2kvIUVKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlWUp3dm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8F606A32C
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlWUp3dm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5493C1F000C6;
	Sun, 22 Nov 2026 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795368087;
	bh=qactUoyjpgY5pptL4OazGhQ4h7pIDgNLQg3L1qeBdho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DlWUp3dmD9Z9ZqTxT2C5j+emQ+4msQtDCjFGN7NISg72dJi7aDh323DNMrVs+ZOqA
	 EgsNYLToMhWKiJE2S3rQegKR715uEsHFsI7j6IvtPfQamskA60+X8yMG7N5jVUmDgl
	 xYF/M+cz8JK6rjGJN6dZRTmaWoXmAA75lfi3raB31eLgUhi3/LMBgkwLbfxzBmevFy
	 t+UqTmsGhAW8c/cUVmDIvb5Yfc5idP79/Ggu4OZtkMA1ec6VuqUAK6qseTC8fXUTwZ
	 RGYCnX9rZw6dmX6eNVGgln0/65mENkVixjztWAFb7rBnuuz3jrvMcaWZr0rw4vVjab
	 wJ4blMqkheWQw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 02/27] mm/damon/core: implement data attribute report queue
Date: Sun, 22 Nov 2026 09:21:14 -0800
Message-ID: <20261122172119.153755-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANOyQmE9kM_WgOneXhQ29HTFDLYJwdzWjVKj4e11ESTtT7K2Rg@mail.gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 23 Nov 2026 02:43:18 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> On Sun, Nov 22, 2026 at 8:00 AM SJ Park <sj@kernel.org> wrote:
> >
> > Implement DAMON core internal data structure for queuing received
> > data attribute reports.  Initialize the queue for up to 1,000 reports,
> > inside the DAMON init routine.  Destroy damon_region_cache and reset the
> > pointer for the queue setup failures.
> >
> 
> Looks good to me.
> 
> BTW, while reviewing this, I noticed a pre-existing issue in DAMON
> sysfs. If the core fails to initialize, sysfs still registers the
> interface, and trying to start monitoring with an initial region can
> hit a NULL pointer dereference.Maybe I'll send a separate patch
> to fix it.

Thank you for reporting it, looking forward to the patch!

> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thank you for reviewing!


Thanks,
SJ

[...]
