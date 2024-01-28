Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17101DDD2
	for <damon@lists.linux.dev>; Sun, 28 Jan 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706433188; cv=none; b=TM6sqE/QajhRHdwVAXoDqC+SLz1+6Ab6MLMdrAFpcYs/J9qrhT9CXPHBT/K6fJgxiR9daQJ9r0q5EFl3TgpPyPBVWuyJYcBWceenTMGIlwNAWSEKQ/4h98A2gjDKqsTLrq4PdJDCzzP1IsCl3McPQDWdbZt2oGflzXZ5TzaGLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706433188; c=relaxed/simple;
	bh=drbntK7WnTrqoWixjDyY46SJXUNRW+i/vKdTVgVyrPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvZdqsqNsu70fDUAZLbQrqeh1ywi3zWCXKYmQZgjcRrsZswYgmRup1Yo3SU3e3BADVa+Ra2ID3EM3GKLUvuVkbJwdgbt9W3Z3Zsnq+w0KtVGDvZXKvq0oWak5byUACLKGkeNjzwQ0q71Y/S5whHk65VvUQpFS6IOPEHY/VIF34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ/kAVlS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ/kAVlS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso813818a12.2
        for <damon@lists.linux.dev>; Sun, 28 Jan 2024 01:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706433186; x=1707037986; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=acLZOEynjKiK7s/lexC5VGK4yZ4FEotAitBzQjrV9U4=;
        b=EJ/kAVlS/Lo5WvXgg/6mPYz40ZuJwrwRKF4TNlR4kuK+Ei5G1UubjO4nRbw28uejQM
         roSAhIdu47ypyvvv/E4W3WqQN1bstFTEXIU5bZah5qhoadQFwxNzx8nO5CbRgrE191/W
         oQ6/XuMGcN9k7LtRJMeY62okoSJMKHT/qv/C7DB2wcTo0E1X9FxF0+oCQWmyZ6W9s3ni
         5hkTLQLHpX7+X8S928U+Fx0UONd/qrU93/ufj37WrKftPbMoUWky8ZkfLV95fKaXAtRI
         D0wDxvsXWNC/rp2ca2Oq9uIuxZhykfNRBMiWPXMJbEot6dPWdZdXeogkpKLLXv1uIXGp
         h8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706433186; x=1707037986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acLZOEynjKiK7s/lexC5VGK4yZ4FEotAitBzQjrV9U4=;
        b=kuCy+jk65TQRAySjax8AvzxNxvOrPtzoEIAepQBsmzcR8XtTOmcTeP39Xye4wpv0nz
         OeMX1HyKmjVJ/xpK/Q+UpEKOxYoivnEes1P9LtC2Yfa1zB/70a8sJgi1yhvS2BUkuNbI
         nSS3J6EDE5UBSMeLQZ+KKoEUtWNegPGMf2XXDA3DM9t+4etyYUiEulg5suWTjYi05V+H
         XAEb235zpXw0b9QqYdsp+izLQE4kNZ5N4otq8kkOP3EiWoFKYC0GQOPkc423CYL+1q2n
         PjLidKhRpZLMXeyXGkpvOeVeK+YjOlBYnzsPCUnML77MgWCmuWnY9s8RGKrT9f2QIm3s
         R6NQ==
X-Gm-Message-State: AOJu0YxrgfBu06XEwi0T9phC8bWQ1gV3mvEY6Rg9GHtXKRKYuFcrOJcW
	LLvM62iRwa7R9q3LVvC5fGdyHRWoBmoHCM9d24r502NueAx/dZys
X-Google-Smtp-Source: AGHT+IGVSXMwhvAVXiaEic9M2v+ZLMqMnlBUCWXEZ/jyvI1kYhN2vFmSFunS2p0WsjEPHkQi2jI5yg==
X-Received: by 2002:a05:6a20:6d4:b0:19c:9d4d:7d7 with SMTP id f20-20020a056a2006d400b0019c9d4d07d7mr1724532pzf.41.1706433186004;
        Sun, 28 Jan 2024 01:13:06 -0800 (PST)
Received: from cyp-ubuntu ([43.224.245.229])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a00228e00b006dde27853afsm3800852pfe.113.2024.01.28.01.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 01:13:05 -0800 (PST)
Date: Sun, 28 Jan 2024 17:13:00 +0800
From: cuiyangpei <cuiyangpei@gmail.com>
To: SeongJae Park <sj38.park@gmail.com>, sj@kernel.org,
	akpm@linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <ZbYanPU16klwz0HA@cyp-ubuntu>
References: <20240126065706.GA16652@cuiyangpei>
 <20240126080454.15649-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126080454.15649-1-sj@kernel.org>

On Fri, Jan 26, 2024 at 12:04:54AM -0800, SeongJae Park wrote:
> On Fri, 26 Jan 2024 14:57:06 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > On Mon, Jan 22, 2024 at 09:56:11AM -0800, SeongJae Park wrote:
> > > Hi cuiyangpei,
> > > 
> > > On Mon, 22 Jan 2024 13:46:31 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > 
> > > > On Sun, Dec 03, 2023 at 07:37:45PM +0000, SeongJae Park wrote:
> > > > > On 2023-12-03T13:43:13+08:00 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > > 
> > > > > > On Fri, Dec 01, 2023 at 05:31:12PM +0000, SeongJae Park wrote:
> > > > > > > Hi Cuiyangpei,
> > > > > > > 
> > > > > > > On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > > > > 
> > > > > > > > On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > > > > > > > > Hi Cuiyangpei,
> > > > > > > > > 
> > > > > > > > > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> [...]
> > > > Is there any way to catch sampling result immediately after setting the
> > > > "update_schemes_tried_regions" state?
> > > 
> > > There is no way for exactly doing this.  You would need to proactively collect
> > > snapshots while the app is foreground, and use the latest one that collected
> > > before the app goes background, like recording-based approach would do.
> > > 
> > > I think recent DAMON changes might make an alternative approach available,
> > > though.  From v6.7, DAMON provides pseudo-moving-average monitoring result in
> > > sampling interval granualrity, since patchset "mm/damon: provide pseudo-moving
> > > sum based access rate".  And a followup patchset, namely "mm/damon: implement
> > > DAMOS apply intervals", has made DAMOS works in the sampling interval
> > > granualrity.  Both patchsets are merged into v6.7-rc1.
> > > 
> > > Hence, I think you could use 'update_schemes_tried_regions' after you noticed
> > > the app's state transition, with DAMOS apply interval of one sampling interval.
> > > Then you will get the monitoring results after one sampling interval.  Of
> > > course, the snapshot may contain some of background access pattern, but
> > > wouldn't made it changed significantly, unless you set aggregation interval too
> > > short.
> > 
> > All other actions will apply at one sampling interval except for the
> > `stat` action.
> > 
> > We use 'update_schemes_tried_regions' after switch to the background. The 
> > before_damos_apply callback function will only be set when the next aggregation
> > interval arrives. The `tried_regions` will only be updated after setting the 
> > callback function. 
> > 
> > DAMON is still sampling during setting 'update_schemes_tried_regions' to the next
> > aggregation time, which is not what we expected. The pseudo-moving-average
> > monitoring result can reduce nr_accesees inaccuracy, but age is still being modified
> > during this time, so it can't improve this issue.
> > 
> > Please let me know if my understanding is incorrect. Thank you.
> 
> So, 'update_schemes_tried_regions' command is firstly handled by
> 'damon_sysfs_cmd_request_callback()', which is registered as
> after_wmarks_check() and after_aggregation() callback.  Hence
> 'update_schemes_tried_regions' command is still effectively working in
> aggregation interval granularity.  I think this is what you found, right?
> 
Yes.
> If I'm not wrongly understanding your point, I think the concern is valid.  I
> think we should make it works in sampling interval granularity.  I will try to
> make so.  Would that work for your use case?
> 
It's much better than working in aggregation interval.

I have a question. Why does the 'update_schemes_tried_regions' command need to work
in the sampling time or aggregation time? 'update_schemes_tried_regions' is a
relatively special state that updates the regions that corresponding operation scheme.
Can it be separated from other states and controlled by sysfs node to respond immediately
after being written?

> > > 
> > > > Alternatively, can it return the "last_nr_accesses" and "last_age" values in
> > > > tried_regions/<N> directory?
> > > 
> > > This could also be a good alternative in my think.  Nice idea.  But, because
> > > the previously mentioned alternative is already available while this require a
> > > bit small but additional changes, could we check if the previously one make
> > > sense and works first?  We could revisit this idea if it turns out the previous
> > > alternative is not suffice in my opinion.
> > > 
> > Can you consider adding "last_nr_accesses" and "last_age"  two files in
> > 'tried_regions/<N>' directory?
> 
> Actually we don't have 'last_age' field, right?  And in case of
> 'last_nr_accesses', it is a hidden private field, since it is intended to be
> accessed by only DAMON core code.  Making it exposed to user means exposing
> implementation details, and the mechanism that coupled with an exposed
> interface is hard to be changed, so be unflexible.  Hence I'd prefer making
> 'update_schemes_tried_regions' works in sampling interval granularity, more
> than exposing the two information if it works for your use case.
> 
Ok, I get it. 
> Thanks,
> SJ
> 
> [...]
