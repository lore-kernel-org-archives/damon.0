Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C92931D3
	for <damon@lists.linux.dev>; Fri, 21 Aug 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321808; cv=none; b=aeBnLETgDMbCS15W3A3E1gpl8dDIDP03FTWCaRnEvY4Gd6hbKVxfKhr5A27qBNtNF9dQN9nHjqDZGhf0Y5XEh+rA/PAOiD29NEVPqb3TmQqil6fxZAeWnXEJEP4BKd/6AZ5k+im80seKu3lcX6C6k718NZyzPfFYq8hCf+jjzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321808; c=relaxed/simple;
	bh=1Kj0rO4K20+RXgoXmNRMaK+bp8FPRYGwsiz0upjN+AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y67XyZeLfxRDIICvY10BUhVCyob2KsSrZUY4Q3BOuppPm0JGRfSWl4MLtzW3ytzR7KaRNnYu6Lq20fw3iypzG9vAXXfhxb8Un/LeCGHLExX77NAWTxc/U7do/7MiGsnyfn/DjW6tTpz1sVMZRSrrYgefTCTn4dF1q2Ouic+n2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6A5ZQT5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6A5ZQT5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso12898365ad.2
        for <damon@lists.linux.dev>; Fri, 21 Aug 2026 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787321807; x=1787926607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gkFIWdQrIG5uSLpHBwsVSrnZ/Bh83b4gEGjaE+vppUY=;
        b=r6A5ZQT5np7CWoZteTTLGaxtGjbOIaVMgpE1waAnQAHrAqToEtt/kcTUnlFrUEJd5V
         Z2QHhtTm9cuMNdJ7RPmRWphmkxS24acmpJbMHZKOij8lYO2MhG6MYAH4chIHtoCZnrnU
         rZ95WAbcfI9pSum0oJlgGdXfYwnZd1FiQGrQqnjsAFsk1n+it2n2SD4RO8KOp3Ye3dmr
         qYzuOGeR65mkpzLJBlv3TieXwf21jWUrTAZ1i/NK4Q9JA88POz+JN3FEeeiAQ3CFWHcg
         N7/zQPDwV2BRazl3oqpGMXs+TvQT0wzZjfz3GRtQvlD/5ybJP9mpBbn8vBA/xVJqsJwn
         iuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321807; x=1787926607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gkFIWdQrIG5uSLpHBwsVSrnZ/Bh83b4gEGjaE+vppUY=;
        b=I4yvUvADWFJ7+8rbLu9LIKW2SogOUQK7ps+5xZ3Io6FZPWkbr9sKLEUBtorEJtUsFs
         kNw791EOTmdTzKOpxuORkTIIJzN3/+KMxev5BZHKtjSNEQeN2RRKhs0dx4O8uoyu+qx6
         Xnu6JgPdya9+pcLI22JB2NYmcLdfdV45HEIMg66IPnsHucXMgwz1GMF7W2muy4jlWWs7
         98EiSZH8EjkoHsv37BJTgxWHgCPvcSYiVQyeaUOAU208Mm5N1mUQuCQtoy1DmokUZ+Ji
         b1a4w8Y/lzkwtdasrs7YInmWJNqShZnvfjPdeU7nWwrv2tTcFhh61CSAKLEQpMUHxfs1
         qf3A==
X-Forwarded-Encrypted: i=1; AHgh+RpvAPN/Wj5tHeJhGSXk61OnFQKTNX/xUjaz6ry1TUfTo47p/FDvRcUrkOpySIMl44CcCdNNdA==@lists.linux.dev
X-Gm-Message-State: AFuF++ln1/z43+qq3go5qYdHdrAurjs941+YcLFVxOsuGkPdmfuYvhoz
	1g1rvosHUrsBasvGrNVPpcw4mSOAuJbKDuGW1beV6+3GFlO53pkCP7+d
X-Gm-Gg: AR+sD10uOcCpxzFevxcWIpV5vtUT5JgP/MHFcSzD8tKLSFcV8szT+v2CzaluPeZm2zb
	0DfmdaCrEWgM4M3vQmpZHPr+Q5ktq4lfBi7BL8uyiQnAGjqHA745gCy+ELLNXbdoNJsz8kSrhK3
	38k4VLG0MB2uNKMXt/W2+CbkoiA7MhhZ+e7Vbh/DYgerxe8bTSe+6dfvvT1JAd54mZA3tQ3vE3M
	iBPFSnNbUOh6fkYzcarFrrnNPuKs/LaB5LHRAHQ0Rhtytr1fkr4WKJdxxwE28AJZUUCEjuzgbuX
	uzzYgFg0HaQlZ5KzYc0BS1BBwoVBW9MqxPbwipKbPebERpgW2x+ueiYaSBfZFXeVDa4sZpOZw4T
	mRaGUsdpgXZj/w4OJ8KsLRvlPskDK29Vg2IAM5YPjv8EQY2qrJVuiLsO4rdg0/tdiW9FwoFs4ql
	bDw7UE6fUbfx8v3t8/f6WD5Z3YBlcRhiEjoo2Sj5vKrsHwD1Dvkzle5cAcwVAIBPoxfg==
X-Received: by 2002:a17:902:ebc2:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2d64adea473mr133703485ad.5.1787321806882;
        Fri, 21 Aug 2026 07:16:46 -0700 (PDT)
Received: from celestia ([2402:1980:8916:4049:ca73:3818:84b0:e2c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62ec88ebfsm19455455ad.84.2026.08.21.07.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:16:46 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	gutierrez.asier@huawei-partners.com,
	linux-mm@kvack.org
Subject: Re: [RFC/Discussion] mm/damon: Helping with alternative for watermarks
Date: Fri, 21 Aug 2026 22:16:54 +0800
Message-ID: <20260821141654.203418-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817135742.75706-1-sj@kernel.org>
References: <20260817135742.75706-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026 06:57:42 -0700 SJ Park <sj@kernel.org> wrote:

> On Mon, 17 Aug 2026 16:39:23 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> > 1. Why use Watermarks? And what was the problem?
> > 
> > I now understand why we do not need better Watermarks, so my answer is
> > based on my previous thought.
> > 
> > I used Watermarks primarily because it is the only mechanism I know for
> > stopping/running a Scheme.  The problem is it can only monitor MemFree.
> 
> Thank you for clarifying.  I'd like to go one step further.  What is the
> initial problem?  Why you need the automatic proactive reclamation?  Do you
> have some data showing the problem?

To be honest, I have not encountered any problems, and I do not have any
rigorous data.  I simply using DAMON to try proactive reclamation, and
see if it would cause any serious issues.  So far, it has not; it has
almost no noticeable negative impact on daily use.

> 
> > 
> > 2. How exactly the page cache becomes a problem for you?
> > 
> > After prolonged computer use, the page cache can become full.
> > DAMON_RECLAIM might then mistakenly assume there is slight memory
> > pressure and reclaim those cached pages.  Unnecessary page cache
> > reclamation can incur unnecessary overhead.
> 
> Thank you for sharing this.  I can theoretically understand the issue.  Maybe
> you are concerned if page cache is too aggressively reclaimed and therefore if
> file io becomes slow.  But I'm not really sure if it is only theoretical or
> real.  Since the proactive reclamation reclaims coldest page first, and because
> it works for not only page cache, the performance impact might not that big in
> real.  Do you have some data showing the problem?

This is currently only theoretical.  I also think that the performance
impact will likely be minimal.  I think adding a MemAvailable option
provides certainty, if users know for sure that their devices will not
lag when MemFree is low, but will when MemAvailable is low, then they
can choose the option that best suits their device based on their own
situation.

However, since DAMOS Quota already supports checking current_value from
user input, and I cannot yet prove whether this option can bring
improvement in any workload, I think we can disregard whether to add
this new option for now.

> 
> > 
> > 3. Has the MemAvailable based one solved your problem?
> > 
> > Yes, using MemAvailable as a watermarks/DAMOS Quota metric can avoid a
> > lot of unnecessary memory reclamation.
> 
> Great to hear that.  I'm curious if you have some data showing the improvement.

While I do not have rigorous data to demonstrate any improvement yet, I
appreciate your guidance on this.

I will continue exploring DAMON on my end, and I might send out some
patches later regarding a few logical issues I noticed in the code.
Thank you again for your time and answers.

Best regards,
Rui Yan
