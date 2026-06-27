Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87C6273D9F
	for <damon@lists.linux.dev>; Sat, 27 Jun 2026 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782596204; cv=none; b=GtUxW834SStonUHgvDRsU4lCWllG/BBVxOoBHXuXzPr6AD1kGNzmvbCEQ6FtxukABfh/ZpGcx59C/DbitjQO7lzzWwlxpTe30MEQEJpAglR8vV01ZVvoSRAIi/4oKrT+DvW4+PVloVxIADJ3mJQnCBWJ55XYC4X269i/eUVeJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782596204; c=relaxed/simple;
	bh=p3Mz7BkfpS+uKpCvACxIZ/VZYXaIPOLtY9ln4fehQ/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ib7rFU/7Mp2ZOdXJlO8wsnHr6dqVm10v33fXPnv+xhXU924+Pci/9CCBTQ2ZtaoY8NxfdIFFFUVJHMeQ1TfgaC2DFZiBl3/8X9Td9mBCDoGm0LidiR1JyFEU2jbED2zRN21UOOes66GIcwJkvgaRrifOmGj9AkjTaAPlhwtcAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn8CYjtK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn8CYjtK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845dd541e49so159801b3a.2
        for <damon@lists.linux.dev>; Sat, 27 Jun 2026 14:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782596203; x=1783201003; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXvatVIXGlRA1p89/xy5prsBIMJ3M0pdIs4NFYTkFQQ=;
        b=Gn8CYjtKTvP8okOoDbulOG6rZd+KcK9IYMavERq8iqHfetNyBMLUIDjAFYWZx+CTfp
         EyiMhklk5s5iX3S0D1SuTpK4z9nmo4UpXXc9W1cV6YoPJtTAHuA4KkpXHxcdKFneAdc0
         NCKTpi4QobXucbminecd2fRovjlWc4MUj64iB0ZVO3T6bH7+3H1kn5ziSs+WNtZf4K5M
         WZklYsGvSB3vLYOYE6LTax+0diutz9dpbHII3gpkdiXZWiUytXfTONUmmkfp2AxSOKnp
         Snt1en+YYYcEtCMlZSIcF4ChAfOE27oJbi0lJJa4N0TgSDsRnvZbaO1Z44FiFb9OFU+u
         Z56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782596203; x=1783201003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXvatVIXGlRA1p89/xy5prsBIMJ3M0pdIs4NFYTkFQQ=;
        b=eEHzqOp35FiLwP1GTjrYbDYNnbMueYSpjXV5QdcRyewnGOr1s5FBtNaxFlVfXslmCA
         Q5sOlXLIOkXqcfyD3DyvuNHfQCzHrRTNWenfUoesGKpTq3NTPbTVMQoivq8GSthjjtmd
         f068ZalAYoXSjqgVqN7I+k0CaLnCBN3n55kYRI/2V74ytKkTyDEXtOsNH/353n9bNHIB
         ilp/jwu83ew3raXIfVpINXE3dIqfOg2kBVVZji990V1PiD97c+iCu6HB35GmA8R6DXE5
         57FsXY5K07+3jnbpmMooLOZQk1N5gEhMdOvAizXYAQw97lQ5RzAPUMAUSKE3Lguy9JbH
         xDxg==
X-Forwarded-Encrypted: i=1; AFNElJ/bbnP7gAUII9BpnkpvT+pAFhnvDlYkVTwufQ1DME1WX4q9f3qzxhbxv17MrQMlO1+2+MScdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzodMmPkIeEPEG34uIPF7RE60AzUNVKB+GbFyuUc1C4YXER3Vxt
	gjqU31uM/pqF3lg+nZB1sqScnsdL/Pyv46//L+3h4dj5Bw9OyamYBgAH
X-Gm-Gg: AfdE7clWNCeQJAv/asN9wc5Fb8L1zxQq1WeJaRwIAAwTAKRVo6ZFk0qdh6Y+0hZDqex
	oZHcOkd1qGSgb/hQLH0eJh9PkTUWgPHFTwLZEZWnrlwv2JtmUg6AAvKVTmfu+hGdvG6QBUKQUN4
	eUKMmlhrb/H0LYodJx1mgSsZh2ZJygZVasWP8cow4CIozpl96squ7QXwFnPyDa+foqFDC2Ffdjp
	QTwmTo6M5gqy5nfnrgaKDnW3/QVbd3aUqCn+ONdQqiM5B9viJ273VflKRa4G+Ea0iPr1oFW29we
	Zc3dScbQJCFH/7GDdOETGCONhVcQsoOXPnVALip2wBqGH/4ba96A3TQaMZcqBhMfznxpGW4p0DB
	5j426WIGUEMLJHk7GZhiMxLVRo+bVKl+3JW0rVsLqbXcbd52K+kzD30r8nGxyXxljfFdiP2aEYV
	fteCgsXKbge4kaTnzI9eGCjmqgPMcow1KKO8wgfEoJhyluX/TrF7k=
X-Received: by 2002:a05:6a00:b53:b0:845:c0db:3926 with SMTP id d2e1a72fcca58-845d2475cfdmr4821976b3a.22.1782596202842;
        Sat, 27 Jun 2026 14:36:42 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9a5:e298:5467:317e:e807:794b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3feb7d5sm9112206b3a.14.2026.06.27.14.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 14:36:42 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/reclaim: add 'available' memory as an optional watermarks metric
Date: Sun, 28 Jun 2026 05:36:50 +0800
Message-ID: <20260627213651.19000-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626141819.86269-1-sj@kernel.org>
References: <20260626141819.86269-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi SeongJae,

On Fri, 26 Jun 2026 07:18:18 -0700 SeongJae Park <sj@kernel.org> wrote:

> How about using DAMOS quota with its aim-based auto-tuning, instead?
> 
> I developed DAMOS watermarks and quota as safe guards of DAMOS.  In more
> detail, DAMOS quota is for restricting only resource usage of DAMOS.
> Meanwhile, watermarks is for restricting resource usage of both DAMON and
> DAMOS.  That is, when the watermarks condition is met, not only DAMOS but also
> DAMON is completely paused.  Also, watermarks feature was considered smarter
> than quota, because it is a kind of auto-tuning.
> 
> However, it turned out completely turning DAMON off is not a very good idea,
> because it drops monitoring results when the watermarks condition is met and
> therefore completely stops DAMON and DAMOS.  It drops the region shapes and
> 'age' information.  Especially, 'age' of some regions commonly cumulated up to
> hours or even days.  Dropping that was a problem in production use cases.

I looked at the code and noticed that kdamond_wait_activation()
doesn't seem to free the regions, the data remains in memory. By "drops",
do you mean the age information becomes stale/unreliable during the
inactive period rather than being literally discarded?

> 
> Meanwhile, we introduced aim-oriented DAMOS quota auto-tuning (a.k.a DAMOS
> quota goal).  It made DAMOS quota smarter and easier to extend than watermarks.
> Nowadays, users can also pause and resume [1] DAMON/DAMOS without losing the
> monitoring information when they want.
> 
> So, I personally don't encourage people to use watermarks.  Of course, I may
> missing some problems in alternatives.  Hence I'm asking the question to you.
> 
> How about using DAMOS quota with its aim-based auto-tuning, instead?  If you
> cannot, could you share more details?
> 
> I'll hold reviewing the code until this high level discussion is resolved.
> 
> [1] https://lore.kernel.org/20260427151231.113429-1-sj@kernel.org

Thank you for the detailed explanation. I now understand that watermarks
pause the entire DAMON monitoring loop rather than just gating DAMOS
actions. I agree this makes watermarks unsuitable for the Android use
case I described.

I will drop this patch. I think controlling DAMOS pause/rusume
separately might be better suited for execution in user space (such as
controlling‘quota_ms’ and ‘quota_sz’).

By the way, I sent you an email about three weeks ago (Fri, 5 Jun 2026
20:28:00 +0800) introducing a userspace auto-tuner program I wrote for
DAMON_RECLAIM's 'min_age', and asking for your thoughts. I am not sure
if it reached you, could you please check? I would really appreciate
your feedback on that as well.

Best regards,
Rui Yan
