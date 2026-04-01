Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE6E37F8BC
	for <damon@lists.linux.dev>; Wed,  1 Apr 2026 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031836; cv=none; b=PnixuIaFMsI8wgn2M8WB/PEF8yY5olrCe5Ndn4o82C0DnNiFGw1zy/eIsnuK3M8z4GHRblIzvaU7DgERjE1un0A6sRXIO8mcDAYLylBYryLI87tWNXwbvPNjlfgvT6OGHMqvnLzuao8+SIRkVFEn2sn8j+0ND1yYqcpI3Zy71LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031836; c=relaxed/simple;
	bh=UvI2F14jOy94gqCpgzkbEkLWB8mw/d7C2KTcJ5JbkG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bj5EdNtVdNM5cYRTOyOG1dbf3cUQE7TFpyoJ0w6qfUEP/UEo6Jg/mbPj4GXL7dRHiPnxGSqngoulUtzitj9XuJWTux6FkaoH2UvjisDaHqwKwqGYDntnkQVT5GUPwBSWP4JEEwJu0WgEJqnEPHV15cNcJR7eGaqszeNdwH3/ghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1vUN012; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1vUN012"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so4917635ad.1
        for <damon@lists.linux.dev>; Wed, 01 Apr 2026 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775031835; x=1775636635; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tahSagRy2rxRu2goCN+5yCBu9Tsu0dbKR4tdDc4VDo=;
        b=j1vUN012QqsiuDW2JYL2yNrSc7Qmhyz0rhriuK1rNbCRng4ovA3VLWNN7OgumoMxSf
         OA+OTu+rLAYWlCT5nSn8R1aRtuEHY/Mv/IzdnbOeqqdIrSsn2if5lAF0Hq0VUL0X0+qH
         c6Nq0GamiE8TLwKxDDhRJ5bowAeYYUOz43QCOQlLZ45i8jAdsd+yBNmtQTDPn7GSNjYr
         3zJAp9JgmWgz5nmxheYaj2SS17MQwo7y6ZHU/sTLCSBnEnPwlBeOJVQoLqo/gaehbypL
         4cU6eRPnNcwIPNemyHNKx8FSvvSNvqA2ZNqth4Ee8OQ5r40y4UAayfPsjhRHSTg/SZDM
         IhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775031835; x=1775636635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tahSagRy2rxRu2goCN+5yCBu9Tsu0dbKR4tdDc4VDo=;
        b=RXNYzhUa57IlNQK0UnBRuxN3/2isF49g0POGn/UGvNtNwrK2JEELrOxjK2AgPeAVhT
         snfI3awrtXPXInqt764MS3/eLa3AHcsEvDU63B7NCnGOdHC6yVciJkUoDCA4duadBRa7
         QhplX++CebyLHTQ/Crpkl5lkVARs6u7NeNqOmHJrrMV4h/QFjPkDTcFu+zEPqBAHmoGj
         3xH0P/h4HkOaDftI8eDeMDOJ5QItKscdxhSAD6JXeMpP67Q8MH3u2i4RUKvu0p6So4oe
         o/OYWyNwakk9+AffpnS5V8dLgc8AF6fvluUMf7UDFnv8+UfSuV5Lnf29aBsIyUNVHDvd
         SW0A==
X-Forwarded-Encrypted: i=1; AJvYcCV8VPiIc70aDFaF8QtDkl//pJNeL9a6ErG5QQpqzPvG4rRVOswaBsviXDpPB3Y+13lWbOOKFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKUURyd4cx09AWBKfkhvyuExRmN1WcdjsVdSWdab6n5lYqgxeo
	bCxKu7BAUaXOQEjA3GO99ecjA6kAdhRfgH+l07ZDcy3yoIGouefL7hkE
X-Gm-Gg: ATEYQzzAslIzA6izSXH5AAVN3QchxvwRqF6vn/tXudxWFml03lnjKUPnnhTWSckLZj1
	c6ruIYj9RVG5cIigDqNeLuH/T6hH4JTfWmeCZueOcZGP08tOIY4JcOWgbP8JI1NjBGac16GVLyz
	2E0ENOVgujxFm549WFY2Ln0JOmxCq4vHIp8vJuP5EjMShpxJ6HOxf5B9dAAIulWWqFNbFqdZtUr
	q02ELeSS9vneeRCQHY9HZ0jCQi4gXH/vBSq5aLYN45yeYiI56edSQfg4KX9xfZTZprGkTOuDc96
	xvw45Ti/WEZytrtqV1rUsbKiQwbKpA6Mv/HYP0VRH6qOzT+RUBeu7ZhpNwMt3ZLGPLGu/xKKp6/
	K8GlIVUl9yW3vNorZzhZlvd069yKt5+uONrxGuCcglD0q4COLWvxygkRJc54wUB74uP2yioE/js
	1G35c8ZIkXwKpDoeAnbVfl5upe7SEOBTIE53PdvL1huas/rm7yRaw=
X-Received: by 2002:a17:902:e54f:b0:2b2:5168:2f82 with SMTP id d9443c01a7336-2b25ef80e90mr62217495ad.24.1775031834583;
        Wed, 01 Apr 2026 01:23:54 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24ddc0afbsm142463115ad.64.2026.04.01.01.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:23:54 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: reset thread status parameters upon kdamond termination
Date: Wed,  1 Apr 2026 16:23:54 +0800
Message-ID: <20260401082354.12467-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401002918.85255-1-sj@kernel.org>
References: <20260401002918.85255-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

First of all, I apologize for not completely answering your question,
and I will be more careful next time.

On Tue, 31 Mar 2026 17:29:18 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 31 Mar 2026 14:58:36 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Hi SeongJae,
> > 
> > On Mon, 30 Mar 2026 22:02:28 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > Nice catch!
> > > 
> > > I guess this can easily reproducible?  Sharing detailed reproduction steps
> > > would be nice.
> > 
> > I will include the reproduction steps in the next version.
> 
> Please completely answer questions.  You didn't answer the first question.

Yes, this issue is easily reproducible. Specifically, setting
'addr_unit=3' and then 'commit_inputs=Y' triggers it. I will include the
detailed reproduction steps in the next version's commit message.

> > > [...]
> > > This feels too much extension of core API for a problem that can more simply be
> > > fixed.  Can't we detect the unexpected termination of kdamond from the modules
> > > and update the paramter values accordingly?

Yes, we can detect it. From the module, we can check '!
damon_is_running(ctx)' in conjunction with 'ctx->maybe_corrupted'. Since
'maybe_corrupted' persists until the next initialization, it
effectively indicates whether the kdamond terminated unexpectedly.

> [...]
> Please do not add '> ' to your reply.  This confuses me.  Also, again, please
> completely answer questions.  You didn't answer if we can or cannot detect the
> unexpected termination.

I'm very sorry for the formatting error. I accidentally miselected lines
in my editor while batch-prepending "> " to the quoted text. I will be
much more careful with my editor operations.

> I will reply to below in another reply, as you added a few things to that part,
> while cutting the above part.  When you reply to your reply, please consider
> keeping the previous reply part.  Then I can reply to your two mails at one
> place.  That would help my life :)

Understood! I will keep the previous context in my replies to make the
discussion easier to follow and reply. Thank you for your patience and
guidance!

Best regards,
Rui Yan
