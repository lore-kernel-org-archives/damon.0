Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BA3ED12B
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 22:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910557; cv=none; b=BlY/lqG3ZDEgXdhI68xKLYFFNxw5zOxSY7jRjTO7cZrJzupc/FWrQQRLaGHO2hvr52EoU9avqOijlQQhqsGDQBKLyZ5U6leIo5BfC0wNkTrHzXDz2SxaqlXXuaQJvzBAvxUxqeWxiP81BT7gGE9SwJz0kJxnZ1fI6m8C7KrdlK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910557; c=relaxed/simple;
	bh=Zs+gfdz6lEjOFm0YRa6rVyvVD81K84GOC3Bnrb9dBNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvhgIQh37bOZHYlakD+XCJZVBq89vMhAFxb4xMUhStfhA+1mgLYu5vQswzieh36L5PTT8mB9SWiOY1I8JY5nse1yDPs6gZBeeX4ioMW8Far926q597BLUGytXAYCYozU8X5znzumvcgWTUfcgwyeLqalMGFtPkC3miumSmpc32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsjV0WSc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsjV0WSc"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so1747710a91.3
        for <damon@lists.linux.dev>; Mon, 30 Mar 2026 15:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774910554; x=1775515354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOzLtK2W1VXiFd7PdlgYDJK0jWA7BV31CiHuWpEPBJA=;
        b=AsjV0WSc45cYD4/3LKzPffQir3M65kPIEpqvwSzyvU2H5dH4b+ca1Z3qp8zfXo282D
         EXhZ/292Dsimwc2kZfC958HKYrBkPQ6N5X+jFAiQkPLHQ2ADgxQdmehWQU/ynPkMR5ed
         kenq5IMPCad4QKpH6FRHOdhSUu3cO4G8iPyV8brpEV/SL9H/sA4GtRoSx0b9Vr9vmYyq
         Ckdx3V862/v8qJOTIVWw2ZEjXBNUWtfM9m0IqanzOKuf92g9VbaEBVGL9PGa29lCSvFj
         Lub5JD45KHiymueKmS0bppVYaibWeymJXUQUzhEnnEYVux3HVCHaLagVTr5nSIYE8qsN
         tahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774910554; x=1775515354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOzLtK2W1VXiFd7PdlgYDJK0jWA7BV31CiHuWpEPBJA=;
        b=FriAMUPPUcCbASez75gI6Miiua8UjyfnhpQUkvBNvhPHvUK7DWA0HBNcpwYQFad7zj
         iTq0RH22dqmyYHLCmGOH6hAMx28+gmlnDuwaEf2cm58WvKYX0JiIIY03UPiFFWtMF4rA
         YTszHEdEk4LsLLq05icHETiwPo9cVpwCItk34ZU/NKQzAvBgUyFV7SjKEi6Gaxm1Iv91
         3Q8zXeH7znc/dh2AAXQuaGPIxNgNbM/laHwXBHwrG9SY2bAOiLObtFVFEWQhoWx8bCSa
         yW+XsUE/whfrT8qh3UimBmMSZn1rKUNriqHwBEWhsIgjsxqoBSUIoDC7SDufYfhOxfJl
         AUrA==
X-Gm-Message-State: AOJu0YySG1GbOqglLxYW8a0irBUt9QmQbRQpkd2f1r3ZB67LZTqbQw2x
	UJo1o4DTpIm93dlPlu/gHJRxvIIPS27rusQYF7LD+Wjes1GJzxURUeWG
X-Gm-Gg: ATEYQzxwd039c6QJmpttxhj/7gw2Ip5692wthWGm2dayxZWLH0twCy0M7uXk1gw5/H4
	k27tvS8uvqscveeYe6VWTxb4u0o41w+zLZ4Lp7uGaTvmbrJbhrTmvpWhtGSVepWhJMH3egU6f1n
	RZhnlwS17TYRbxMN1bOmNKVX2tHHxtSC8C8xBr5WDVo/Wdb7upME9pHOs4zgqwPh9GFqf09McVZ
	StwjQmfIG7T37Mmo/Y3JCv+5CxLUBzCRw86Rq3Hf0aVX8aT0b52EHuuPiiP/Xled34l4yn4QXXc
	Wk3NzOy5CRZP36iVxF0/ZHS76lVqNGkX1PghEhpWCRBHM+y/+7w9DigB4q/zdPZ+O8h+gRDU/YQ
	BbfqBAyHkm8+YN4rmZrd024GjQZskpq5T23QSeN40xBc24LQV1wjO7agjzKKM/CkRApeMXTVasd
	E3awTUXqunzVMx7NCnZNgCqK0Vq1A=
X-Received: by 2002:a17:902:e809:b0:2b0:72c7:3ed8 with SMTP id d9443c01a7336-2b0cdcb074fmr144441025ad.25.1774910553555;
        Mon, 30 Mar 2026 15:42:33 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427658e4sm110689335ad.48.2026.03.30.15.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:42:33 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com,
	sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Tue, 31 Mar 2026 06:42:32 +0800
Message-ID: <20260330224232.14212-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330195107.71609-1-aethernet65535@gmail.com>
References: <20260330195107.71609-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 03:51:07 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> [...]
> > > +static void damon_update_thread_status(struct damon_ctx *ctx)
> > > +{
> > > +	if (ctx->thread_status.kdamond_pid)
> > > +		*ctx->thread_status.kdamond_pid = -1;
> > > +	if (ctx->thread_status.enabled)
> > > +		*ctx->thread_status.enabled = false;
> > 
> > Can this write race with the user enabling the module? If a user writes 'Y'
> > to 'enabled', the store function spawns kdamond and prepares to set 'enabled'
> > to true. If kdamond exits immediately (e.g., due to invalid targets), could
> > this line asynchronously set 'enabled' to false before the store function
> > overwrites it with true?
> > 
> > If so, the system would be left in a state where the thread is dead but
> > 'enabled' is true. Subsequent attempts to write 'N' to 'enabled' would fail
> > on damon_stop(), leaving the module permanently locked.
> 
> You are right. I now see the potential race between kdamond exiting and
> the enabled_store(). While it seems unlikely, the window exists and
> could lead to an inconsistent state. I'm sitll thinking about the way to
> synchronize this without introducing new issues. I will try to address
> this is next-version once I have a solid plan.

I think I've found a solution for the race.

In damon_lru_sort_enabled_store(), the current code sets 'enabled =
enable' only after damon_lru_sort_turn(enable) returns successfully.
This creates the window you mentioned.

I plan to update 'enabled' before calling damon_lru_sort_turn(), and
rollback the value only if the turn operation fails.

Best regards,
Rui Yan
