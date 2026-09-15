Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AA4A441C
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507173; cv=none; b=faUtYTsYsVeRnlLneA3cxeCTMV0e9ed2YEQVGoLYh2eQATOIYP2mXgaF+R0xmI9JEw16jCwqCWUBbEK6NsvZEFirr4Z6F81X5M3qUE2jOtxyXEk/Uvl2veh8hVW2cqHwd8um1t98OSZNXd5xQE3wZnWZwjHusiDmJB0NZYQ+oEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507173; c=relaxed/simple;
	bh=DFATj74VujMU8//zygZj+iFWMIlx/mGWnRaQ4jp2bvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUUN9vBsrkUozkgTX3LJERWAjNIfw/cKiOywQ9GjI0dmIqV5YhDj3QTTjUbTwFhL+/+0sZMgQthmxCyFw5YXCzkm1cxNx5gZj2SxlkJYwJeb4+IgIq5lfHx3BbwAAebTk4rkL+ULtgA+wN+LI3AwoaUyY/INwGGfQJd5yM3T6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h61zaGS9; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h61zaGS9"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so3417135e9.1
        for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789507170; x=1790111970; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D5wwx/Pk3zkVIRABUWvpOwMc3Rzh9znio31a5NcZ404=;
        b=h61zaGS9nFlpLzKh6TeWYloHsosuCZPoPrj8oNPTaYQTUUXwkluB5kojndSuRLkWAN
         WgdYdgxfsZVj7hLI1SzOWmqNvzB7jEhpcZBKse08QA35sHeJtiBVJjXb4Num00bXIctJ
         O8RqSkzpcJKQOosYC9NrVaTwSHSgMyVtrA5RcxyR7ch//wGbZslGys6uMxX9L/ihzcVr
         FHet1cJtcqkB8aIr9dhV1d91O6j0xtwaIlipjIlmxVMmGQFH9zk/fHqirc2mV/WuP90S
         MAdwEarTPM2Yc0fhkx8B8F8iuAEwhK1coJhZXh++vGmQWHuAWv8pOojZ15wYg791UpPF
         SrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789507170; x=1790111970;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D5wwx/Pk3zkVIRABUWvpOwMc3Rzh9znio31a5NcZ404=;
        b=No48TTCcFOyfFDs2gByfWpMpDXk4SBZbnn/a2wOa7pMGCX9ysmPbVeGcilcQ/sBeAQ
         0pur5vo5LquB1NwMDTgWapCnlB68i+/Pl8Sl5NyaUr0YPECikBd2oByvwUBg3e95mgXa
         8c7vhZ5okS4qu0Dc+qqaYkPaIkv3MPRM7CSJQWWQTVwZIna+axABBLlmh7Xctfq8YhCr
         O9lxIPbSst9ThOAqaPHdiaJ7yYWsuCEXFygBseDwi3xy1EbWeSPLZh+nvJt0rjb6K26+
         HF+Wd1mDwKgodT/8BtdhdykFW+A2QSM/tBuvHvM0zZDb6as2n7nqWrBmK4PmSaJ9byKw
         ns7w==
X-Forwarded-Encrypted: i=1; AKwUvByfh5ooDgVITbZnTNJvz1af5fByYJM212cYRQArVAnkP/IbmGna0qyvtkg7ap5QgtpbraLqhA==@lists.linux.dev
X-Gm-Message-State: AFuF++nGisN05BIe8hCtEABuo7/UqotTCp60cfC95Dt25SISm5aA6ogT
	pRPzwa3ujrN+FlCqZQAbDGhVvB23/rZIeMHkBfHNamF2JvLoNGMppl/eybAlnw==
X-Gm-Gg: AYBFou0lCv3wS//0Z6QMuiWCVqEIvZX6xzGG4deeWsM46mKgLXWR//JkIFFRVVpysui
	DgxAC6yOpYEt7I/nSjR+zVYQvMGEJAhFb7qSvjv6LqQfORIycrN9u41ASrR1mln1vVdz6vSGG6v
	bnqfMDeWdvDEvs40oTkpHZ2qp9fcM06/uNzjvSZp7pesTtku1NnITGULVKjpoCmKMA/l3IxgPt+
	Ux0cNFA/ogWTf3rXsLyGTv7XQ1nOx5dMRd7HoKfDNG1qIUplROP74NvB6CAL5lcjgZ8UOavwk/o
	Kx5E8cxJT983fDE9Fbf4/CzECQwYGUzTLf7wjEOB9BzH1yxKvaSZoidGLw+DVBDfK7kdAW2PYB7
	/yhueHyaXQ8DHTJXF7oQwIcHPNFU3V4Da/N9rUblsWl10A6JVloBmwj2Z8MdbUBa2aTqXdM8ymo
	i9xND4J7CAzQVAJa3Lh4e0ULMOhzy5zEwmHOXDypSKX692pfHTYYdXOEsZOAxVx+gE035x7mItB
	/DlJ8wW/Gu9lMiaFpj7pVfW+CkQWy855CxVc6M0oH63SzmAx2AIH3y1FGQJnMZOSwhhGZsfmXea
	X8w63hNSN5tTOSuHq/XVH307Xr5+EyorPPm+34UbOcotLWGYm7wJLeoq9K8ptLma6MGzDXY=
X-Received: by 2002:a05:600c:1c0e:b0:499:be2d:c290 with SMTP id 5b1f17b1804b1-49e8222a2aamr39456665e9.9.1789507169739;
        Tue, 15 Sep 2026 14:19:29 -0700 (PDT)
Received: from MBP-von-Karl (dynamic-2a02-3100-afd5-c801-ec9e-1a2a-2fc8-3f88.310.pool.telefonica.de. [2a02:3100:afd5:c801:ec9e:1a2a:2fc8:3f88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27198sm1671382f8f.15.2026.09.15.14.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:19:29 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:19:27 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: score an unmeasured PSI goal as not
 achieved for the temporal tuner
Message-ID: <aqm1ZPUHiXf9PFWq@gmail.com>
References: <20260915060937.3423-2-kmehltretter@gmail.com>
 <20260915145054.92001-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915145054.92001-1-sj@kernel.org>

On Tue, Sep 15, 2026 at 07:50:54AM +0100, SJ Park wrote:
> 
> The intention is to make no effect this round.  Setting current_value to zero
> to temporal tuner means it will now have highest quota it could have.  If the
> effective quota before this was zero, it gets an effect.
> 
> Ideally, we should somehow remember what was the last esz and keep it.  I have
> no good idea for doing that with minimum change.  This is a corner case in my
> opinion (correct me if I'm wrong) so I want to keep the change as simple as
> possible.
> 
> If there is not easy way to do that, I think just keeping the behavior but
> making it explicitly explained might be better.
> 

Hello SJ,

I believe I have a version that addresses your concern without adding
too much complexity.

In short, it leaves the tuners as they are and instead keeps
last_psi_total across a commit of an existing PSI goal, as the code
did before a68878f83ae6. The U64_MAX round then happens only once per
new goal.

That also covers anything that commits before every tuning round,
like the user_input feedback path or "damo tune", which currently
never gets a measured round on either tuner.

I will test that and send it as v2.

Thanks,
Karl
