Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE33741D629
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547784; cv=none; b=kvWC4DVEWCT5TTky0OJfdagaCcNXJUqlphEM7DMPYPQC5uyxc8a95BaP+HquJkCjt731SVU9j9v97oYMvaHe5Oda+cCM5Zj7Slg4sdLjH8KcNmn1FP/3pj7UIYe3EzKnB8sk17yeyioHcA/4q6wPhtLKHuxsMStJV0v3pBgHKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547784; c=relaxed/simple;
	bh=ifktK8r0TxUbI6jmjOXLmVzsgIG8WqQco9gMUnGkAU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apTnNcrFLcn/kO791juLCgylq7QUp79eV8UQFaA0kFB7N7O1xASOt/DVSWPhvK0ppbVqEnT1p/IohJj5nnS2nLFjPxMX/4mqYKNd/BEK8FHgO+hJcSAJG+XpulDx8xCnza9X+lE8dJmzQCtE6A4sua6HewZ1WZmS4D5ldZ+U9fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVeOY66m; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVeOY66m"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so2883359a12.2
        for <damon@lists.linux.dev>; Fri, 09 Oct 2026 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547779; x=1792152579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJN6L3Z0BRVrqG/DbxfAbbB7P5rB4RPpZa9d14nZmOw=;
        b=CVeOY66my/k2GHfBgHn8QuC3tfrZnvpOfUXjINNB/Zvp4mZM0O99a5hNyl4bOgLS2j
         /fur8iXi6SncIFAux+bb4y5yi2ZXL0g2RJlhGo8oHtpUIXT4q0zHW6AUXwYNIAP0GqNp
         6gjJtMOq6ulqArZFk33+0cjAGr1BGydRcVAoypSC+5P3u+8z9ANcFzriR/HrYo2TC1a0
         BDI/iYLd4VW8AYUD5/gfbsIx8lJDjEmXnflQrsfL33VSc52wOw1qj5UJwu8oHhVmk92A
         vel5oKSJoCmavUWwUUX3VCFMDsyNefB5pkt2oRNl5G9P1B3gerSH/c71fimEq3BdtYei
         WFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547779; x=1792152579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJN6L3Z0BRVrqG/DbxfAbbB7P5rB4RPpZa9d14nZmOw=;
        b=CtNUXg0SqjARKyemI8cj6n2LS0ZF1utgZHSBaYhnfPko6DWj+SrLDZTz3/w/vT5f7G
         fpKOzkMUB8olA5xDGVj6DyWJ4eC6ruusv5fFuGb0+61uNovtM0CgGxvqyLfHVjfGceg9
         0XrXBXnTDQVpR3MWmn+fvh7w5CfZlRi5SoPUk2X1FRsFSpc8jIvajEmojWnnsurn3Uty
         epsIIg9XsaDIlEqdxnEiQHwboTgfE7rQGnewiAks+TneGbi76H8uVllsh92iaBdmCzNS
         pHWyLD3Tt6kPWnJl4IjS4LBgZmLBEvTLqxXahZsaJnvJBMO6HGGkvacQMDs4WgzYnT08
         8l5A==
X-Forwarded-Encrypted: i=1; AKwUvByfuh2BwPEqVLU7Is+cZTQCFxoDhIv1gus33JqYaZeb/h/iUNrq4ABqpxlERx/U6+uFWi6lfg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLHhKPMG26oivxuqNUOCPsHUSQYrhlrI8oONOfc9oaA/oGamGty
	5ZnuPZBaCUYYThkqQmmaNQYBAKDA3ERhyppL3t8vnUOACtIkNA4GMhSd
X-Gm-Gg: AYBFou0BDw8wmgaaf/vbeMmVwK9LwOs1ZimbNOe4soaKghGTXo0U28Hd6fh8vEhihSV
	BfpwakgUmmmMcOfyQoNZx+EvLDkxj7sZlqS6RXLr0GQ83nQYExsNkPCtq5lCmf8TizAsoZ/5bvP
	kSHrJosBZbkMKsRpfkcABfSQaw8/EGJvFjVqHnXaDyaLjiy8Yze1iDQ3Zi0A1F5m2+Q6p556HeR
	DgtoVon4De4dI8nqJf/EOHgegIOPcJmY29WIy3S2cr460TiSfj3oA4BkrU5SzpRImqEZ1/rv6qs
	n0tcpeERd17SPEg0LdBw1q03XKpXDhLp6Z/nm7Ca/iET4fNK5CRbToTDekL25wXxgg/DXgF5O3I
	oV9CAOGr9nZYz+/RT+a87cpSw2aHm3wcFUTjSe99m7RHoDsfk/kNwACfYYmCqzKVrr7+YJj3rWN
	IqVAxujXcMVpoFfJYG2UK3VjfwG7f8nldprlahN5SRRoL56qUdWmraifE3/WiCYXHyBYZl5+jAT
	u2+oPioDHV+FvVQF2hWu74Xmw==
X-Received: by 2002:a17:90b:2e83:b0:3ab:2d17:51ce with SMTP id 98e67ed59e1d1-3ab3a9116fcmr1554693a91.12.1791547778895;
        Fri, 09 Oct 2026 05:09:38 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8ea:96d7:5eb1:79f7:809d:9087])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm3727762a91.11.2026.10.09.05.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:09:38 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Fri,  9 Oct 2026 20:08:33 +0800
Message-ID: <20261009120950.38879-2-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009080138.41269-1-sj@kernel.org>
References: <20261009080138.41269-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 09 Oct 2026 01:01:38 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri,  9 Oct 2026 00:14:54 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Thu, 08 Oct 2026 08:00:43 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > On Thu,  8 Oct 2026 21:44:19 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > > On Thu, 08 Oct 2026 05:32:31 -0700 SJ Park <sj@kernel.org> wrote:
> > > > 
> > > > > Hi Liew,
> > > > > 
> > > > > On Thu,  8 Oct 2026 20:09:05 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > > 
> > > > > > Hi SJ,
> > > > > > 
> > > > > > Just a reminder, I think you might have missed the question I asked.
> > > > > 
> > > > > Could you please clarify what is the question that is not yet answered?
> > > > 
> > > > It seems I forgot to ask the question, my apologies.
> > > 
> > > No worry!
> > > 
> > > > 
> > > > I would like to ask: after reviewing the reproduction, do you still
> > > > think this is a real issue?  If so, I will start working on a fix.
> > > 
> > > I'm not good at reading the diff in your previous reply.  It makes me difficult
> > > to understand what the issue is.  So I tried the commands on my system.
> > > 
> > > '''
> > > $ sudo ./damo start
> > > $ sudo ./damo args damon > damo_args_damon.json
> > > $ sudo ./damo report damon --json > damo_report_damon.json
> > > $ sudo ./damo stop
> > > $ sudo ./damo start --kdamonds damo_args_damon.json
> > > $ sudo ./damo report damon --json > damo_report_damon_aftr.json
> > > $ diff -u damo_report_damon.json damo_report_damon_aftr.json
> > > --- damo_report_damon.json      2026-10-08 07:56:04.979178016 -0700
> > > +++ damo_report_damon_aftr.json 2026-10-08 07:56:27.717941609 -0700
> > > @@ -1,7 +1,7 @@
> > >  [
> > >      {
> > >          "state": "on",
> > > -        "pid": "46402",
> > > +        "pid": "46449",
> > >          "refresh_ms": 0,
> > >          "contexts": [
> > >              {
> > > '''
> > > 
> > > And still it is unclear what is the problem.  Could I ask your elaboration?
> > 
> > Thank you for testing this!
> > 
> > The reason it did not reproduce is that no DAMOS Schemes were configured
> > during this test.
> > 
> > This is a bash script for reproduce:
> > 
> > '''
> > #!/bin/bash
> > 
> > mkdir -p /tmp/config
> > mkdir -p /tmp/output
> > 
> > ./damo args damon \
> > --kdamond --damon_ctx --ops paddr \
> >     --monitoring_intervals 5000 100000 1000000 \
> >     --damon_target --regions 0-4096 \
> >     --damos_scheme --damos_action lru_deprio \
> >         --damos_sz_region 4096 max \
> >         --damos_access_rate 0 max \
> >         --damos_age 120000000 max \
> >         --damos_quota_interval 1000 \
> >         --damos_quota_time 0 \
> >         --damos_quota_space 16777216 \
> >         --damos_quota_weights 0 1000 1000 \
> > > /tmp/config/lru.json
> > 
> > ./damo stop
> > ./damo start --kdamonds /tmp/config/lru.json
> > ./damo args damon > /tmp/output/damo_args_damon.json
> > ./damo report damon --json > /tmp/output/damo_report_damon.json
> > ./damo stop
> > ./damo start --kdamonds /tmp/output/damo_args_damon.json
> > ./damo report damon --json > /tmp/output/damo_report_damon_aftr.json
> > diff -u /tmp/output/damo_report_damon.json /tmp/output/damo_report_damon_aftr.json
> > ./damo stop
> > 
> > rm -r /tmp/config
> > rm -r /tmp/output
> > '''
> 
> Thank you for sharing this script.
> 
> However, issue reports in genral are better to clarify the expected and
> unexpected behaviors of the repro together.  Please add such clarifications
> from the next time.

Thank you for your guidance.

> 
> And maybe because of the lack of such clarification, I still don't get what is
> the problem.  Clarify, please?

Yes.  My expected behavior is to completely save and restore the DAMON
SYSFS configuration, including DAMOS Schemes.  But it cannot done by
'damo args damon'.

In the script I provided, it first apply lru.json and then uses
'damo args damon' to export the current configuration file.  I expected
that reapplying this exported configuration (via 'damo start --kdamonds')
would fully restore the previous DAMON SYSFS setup.

However, the current/unexpected behavior is that it drops the DAMOS
Schemes configuration entirely.  In other words, I cannot fully save
and restore the DAMON SYSFS configuration using 'damo args damon'.

[...]

Best regards,
Rui Yan
