Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B38F45
	for <damon@lists.linux.dev>; Fri, 26 Jan 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256299; cv=none; b=DFjHASdWOe2jWEw5u0xnCTtPLaGqw+2aaGIcROWzMIHpzC3qx2MRBJwvu+ZL5XPm5WcyyMbLyS972UhTzWlgifjPxsjUvVha5qYFXFabMkw6b+KOWOQpLH/SkqsgYxDcvBnepBI16+7hqk4XCw+mxUNmqCVDURqay+zk6BU9FCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256299; c=relaxed/simple;
	bh=vBWqTUqUZtCh3EPJLAcL8wR/fYdkX3CFgMZPjKfyz1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=YsiWXLPa/81gU1LZXBx25YsxPRSRyAxUQz43xkgfQ+rN6x912nkNYKBQCO5Sb0qbcvm19uMsSXNec1/r1Nd2uwrK2Eq09WHJQZfH4C6ACe5lpfjVUtxxXkgYXTN4mdim68Qtl356CITc8+Zb2Ez6XeYza5dJoKr5a6keSVuO7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCuQSKEz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCuQSKEz"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cec32dedf3so190930a12.0
        for <damon@lists.linux.dev>; Fri, 26 Jan 2024 00:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706256298; x=1706861098; darn=lists.linux.dev;
        h=in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PQZqXjnfMiJnpMoo1+KQWc+QVfHQsa7SqRJloMMoGq0=;
        b=RCuQSKEzDR64FSAPnCOdTmigXgMoN/cbOYVt3WkpP8o69ur3fAyN27KCMItUv1wRKb
         4d8vIZE8AlFvDyeXVakjld+OlGJ/hz5cTVgwHog/e2Nz8joxjPQ6m1cp21ruBjmxfU5j
         77qtXQ/B6m7/DlL0OcJQbTNAUc/lT2WqPJZjzpgIM3wrcnJo4ZGtEjbxOX5kvHAIxImt
         h5/qzUVb+4uJwpVeosavxuVB5OZZg8PJGbdpjZG2hUdN1e6tQsA2TB9bjhZjAPp3fUtv
         AY1qQtQ/vfMZcV+9Nt9yoHsLZrW8jjSBThF3Q0SoNUF9V2nwlZB/lywYClpLWKBG4HhX
         iZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256298; x=1706861098;
        h=in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQZqXjnfMiJnpMoo1+KQWc+QVfHQsa7SqRJloMMoGq0=;
        b=fO/I4D2x2D/lg7QiOtUPsT7JzDdyS3+JnY2OWDeEULjwJOSiyeof7jS93Bn6TKR3Kc
         KXUQVIGvqe4dCiZGcHLSQTlBV0PtkwNd40FEqYJUjzEzFfksi99JOrDVQ3F2eBO/Qc5L
         RsKA2DqCmAnteiXHLaMAiiKUxNHByEEsHzeJk9lVV5/7HoQhLdn6O9+yb72TFNJm5Tas
         b0Pe1OEigdlKoCHC/vhQxg5lJS0rcEHeSh1OYWfzoinELziwnsgxM459rkV6JGInVqDr
         SDY1sdvyc0EhBRi4zN4UX4bQ3SyPBPekzg+7YJpgoOPe4r+wnONOfJzUqIXqGqvWmjME
         HcJQ==
X-Gm-Message-State: AOJu0YwSR78R8ldbIv3F1vLdl5bQEDL2nXAeRiRvnVGu7j1pQSwikCZc
	3npuAQMl5eFfAd4LNsxe6sk40ZqND4fJUccfPMIf03SnmEcjFxO2
X-Google-Smtp-Source: AGHT+IGfmbZKkJqn5DYHsnUB/HlbsSD4b7U+wcFk2saImSWOh/tYsOuUy6DJa89k+5XYyr7wqpmGTA==
X-Received: by 2002:a17:90a:6fe2:b0:290:b29a:5258 with SMTP id e89-20020a17090a6fe200b00290b29a5258mr526348pjk.29.1706256297570;
        Fri, 26 Jan 2024 00:04:57 -0800 (PST)
Received: from localhost.localdomain ([216.243.7.87])
        by smtp.gmail.com with ESMTPSA id sk8-20020a17090b2dc800b00290701c8623sm669927pjb.28.2024.01.26.00.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:04:56 -0800 (PST)
From: SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sj@kernel.org>
To: cuiyangpei <cuiyangpei@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiongping1@xiaom.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date: Fri, 26 Jan 2024 00:04:54 -0800
Message-Id: <20240126080454.15649-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240126065706.GA16652@cuiyangpei>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

On Fri, 26 Jan 2024 14:57:06 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> On Mon, Jan 22, 2024 at 09:56:11AM -0800, SeongJae Park wrote:
> > Hi cuiyangpei,
> > 
> > On Mon, 22 Jan 2024 13:46:31 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > 
> > > On Sun, Dec 03, 2023 at 07:37:45PM +0000, SeongJae Park wrote:
> > > > On 2023-12-03T13:43:13+08:00 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > 
> > > > > On Fri, Dec 01, 2023 at 05:31:12PM +0000, SeongJae Park wrote:
> > > > > > Hi Cuiyangpei,
> > > > > > 
> > > > > > On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > > > > 
> > > > > > > On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > > > > > > > Hi Cuiyangpei,
> > > > > > > > 
> > > > > > > > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
[...]
> > > Is there any way to catch sampling result immediately after setting the
> > > "update_schemes_tried_regions" state?
> > 
> > There is no way for exactly doing this.  You would need to proactively collect
> > snapshots while the app is foreground, and use the latest one that collected
> > before the app goes background, like recording-based approach would do.
> > 
> > I think recent DAMON changes might make an alternative approach available,
> > though.  From v6.7, DAMON provides pseudo-moving-average monitoring result in
> > sampling interval granualrity, since patchset "mm/damon: provide pseudo-moving
> > sum based access rate".  And a followup patchset, namely "mm/damon: implement
> > DAMOS apply intervals", has made DAMOS works in the sampling interval
> > granualrity.  Both patchsets are merged into v6.7-rc1.
> > 
> > Hence, I think you could use 'update_schemes_tried_regions' after you noticed
> > the app's state transition, with DAMOS apply interval of one sampling interval.
> > Then you will get the monitoring results after one sampling interval.  Of
> > course, the snapshot may contain some of background access pattern, but
> > wouldn't made it changed significantly, unless you set aggregation interval too
> > short.
> 
> All other actions will apply at one sampling interval except for the
> `stat` action.
> 
> We use 'update_schemes_tried_regions' after switch to the background. The 
> before_damos_apply callback function will only be set when the next aggregation
> interval arrives. The `tried_regions` will only be updated after setting the 
> callback function. 
> 
> DAMON is still sampling during setting 'update_schemes_tried_regions' to the next
> aggregation time, which is not what we expected. The pseudo-moving-average
> monitoring result can reduce nr_accesees inaccuracy, but age is still being modified
> during this time, so it can't improve this issue.
> 
> Please let me know if my understanding is incorrect. Thank you.

So, 'update_schemes_tried_regions' command is firstly handled by
'damon_sysfs_cmd_request_callback()', which is registered as
after_wmarks_check() and after_aggregation() callback.  Hence
'update_schemes_tried_regions' command is still effectively working in
aggregation interval granularity.  I think this is what you found, right?

If I'm not wrongly understanding your point, I think the concern is valid.  I
think we should make it works in sampling interval granularity.  I will try to
make so.  Would that work for your use case?

> > 
> > > Alternatively, can it return the "last_nr_accesses" and "last_age" values in
> > > tried_regions/<N> directory?
> > 
> > This could also be a good alternative in my think.  Nice idea.  But, because
> > the previously mentioned alternative is already available while this require a
> > bit small but additional changes, could we check if the previously one make
> > sense and works first?  We could revisit this idea if it turns out the previous
> > alternative is not suffice in my opinion.
> > 
> Can you consider adding "last_nr_accesses" and "last_age"  two files in
> 'tried_regions/<N>' directory?

Actually we don't have 'last_age' field, right?  And in case of
'last_nr_accesses', it is a hidden private field, since it is intended to be
accessed by only DAMON core code.  Making it exposed to user means exposing
implementation details, and the mechanism that coupled with an exposed
interface is hard to be changed, so be unflexible.  Hence I'd prefer making
'update_schemes_tried_regions' works in sampling interval granularity, more
than exposing the two information if it works for your use case.


Thanks,
SJ

[...]
