Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC32119995E
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751409628; cv=none; b=Xp2B9uSI2zdCKto4CmEJdXyAPWzTm0a9K3Lic4UxQkyJzdSIV96dDHS3Z5jm+Vg/ei/Z/9eBFC65ga15Ad23jlTJrQDrFA8ErSK7YBVHWpIuR7pYfreWqZC6A5ypYpyF5WNcEQKs3PYoZYypN2LrWI9NH15dsYzCpCrtdoYhSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751409628; c=relaxed/simple;
	bh=Jt42u0vTC8jOj2Y3FlPEZCAhDhKdqZfpl7n/CCGzjhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjLIMepk/sa5QEtjtF+N9A254+qoO1v60XBgMHSTnyscSJFXfniDsEvBJXkkVF+GezYp5kf9P6n+x1UEl3dXl9NnGhea66kOMrNcqxa/2GT/LJVlarCwafpzoWXMCIshYQHrh5tprMkJz5nrdgqwAJYuKpQnhlX5NYxOamUKrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRCsk9du; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRCsk9du"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e87c86845d9so2284214276.1
        for <damon@lists.linux.dev>; Tue, 01 Jul 2025 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751409626; x=1752014426; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ppPEYZhg4B0ycuUdBcvBC5LZYOf/2HD/LRvna5W+34=;
        b=SRCsk9dupmSHzGgY7DE5E0KWoytPrY9mJb7BUheEmYZJ8ZckpFzuIfM1dmCGBqpomS
         6ulGVDAZx6rhQmpL1MILeUWFQ4M/WwTmoJFZ5ESq+jEDEqKdTyL4akT9zM8Sve4ZMd5f
         Og6fU+IJZWbAtOlaKAunzt4cIDcgQm2VlKy2QJnDghGx+A1DgS7T6XAMNW6KWfR6MClL
         /3Pl7RyiQ2t6S8YYZUGd/DnRc5iZwvGJU67v08LHyW9vGRvuI/Y8SCWVgwZ4GYEq6OWG
         m343o7rj5/VGIBmogdtSjewq7Ci3xO7IXk9FKxi1zhWwGctlsEblOIl6CF+kN1X4Z9Bq
         tUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751409626; x=1752014426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ppPEYZhg4B0ycuUdBcvBC5LZYOf/2HD/LRvna5W+34=;
        b=kDZ4yYpJnk+Ee2ufB+uJtWT+oIdcS331D2YXg4iRrWM9qyL56uJviUr/baBKZCZRur
         1fPBCJf2AuRtYRtCHxMA+l7y/geBP2IiLr357Gt3qB5OvMgaSqjnfLIWZUUh2wkiiBeu
         ZDs2sIJsHR5s4Vd3IaFSnOiw+td0C/BSBJtKODdImbG2vC7Dy1gtmBZHTnlRyvehP0D3
         FrDuzO5o3GlaUuGv0S3PZoIXQwdX6wWFbkJK6cjvYLyBr5bQ/Y5cX9UtAHQPqqhWJtcX
         EiIGWA/yDQ0PZUgvjOuFbrJEX5N5IDvnb7jl30PTYoNpmuQ+5rIWSHHEQaf4NXsShXMp
         IyoA==
X-Forwarded-Encrypted: i=1; AJvYcCVgpXEkoWZnPlSrOtIlEH7evL2JEXsfSH7kZnTGQZiLRTJODNfK9Um6pDOfp1CPWcCX3KF4Mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyeO0sDZ1lAjiU2KTcC/1/cQp4fWtcR+Tl5EgDRgSL7Tq0QLOh
	oNFxCdLGakYJOG13d+zAEf4O3l4/cWtdg2MG/SJ+HnGW1oqSkK6rcbpO
X-Gm-Gg: ASbGncvFzF3/giKKEAr2YuTvLH/sR/dN2epzSQDz35bYcnv8GPanrqp95fx0LrpP0HR
	yAQRUQ2GEB1dLuZBb8peINnmcoapTJWtLgAM6OZfNqJJN92bBStlkmfu0bPU8pi2v8ERk2aqrIY
	xNcK6n0994B9CCC07kRxeVQoJrBwP40IeHtoyZpYB7wAtsUdW1z1N1eSihdxV/tmdM1SVdYlKHt
	qDZ/Dt1miZYIC76p+5tLkRJO5YkgoSJ/Qtl2HAvWxurpYXs7CGzqB77cO23/wg6oxpPJyfvS7Ec
	7VPnz+v1PcQesgnel3p9KaTn9BVEFNwM9nXan5ZstmSDUBFazTmWKxkdkGKgPQarZmx8ChYfZ9h
	p4z16k44=
X-Google-Smtp-Source: AGHT+IEfSExKlYBLEF5iYY85elbMldfM05dmX2YVT1MmFhly9PsAe+w+JK2QOyqbX2jckL9O0qwTbg==
X-Received: by 2002:a05:6902:f85:b0:e81:28d6:ed5 with SMTP id 3f1490d57ef6-e897e1a1c3fmr915143276.8.1751409625609;
        Tue, 01 Jul 2025 15:40:25 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:bdbc:6e11:c9be:13a3])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6bf2290sm3249392276.53.2025.07.01.15.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:40:25 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: bijan311@gmail.com,
	SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm/damon: add DAMOS_MIGRATE_{HOT,COLD} destination nodes and weights
Date: Tue,  1 Jul 2025 17:39:37 -0500
Message-ID: <20250701224014.9008-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621173131.23917-1-sj@kernel.org>
References: <20250621173131.23917-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Jun 2025 10:31:27 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMOS_MIGRATE_{HOT,COLD} action can migrate pages to only single node.
> It could be useful to allow it migrates pages to multiple nodes with
> different weights.  A work for dynamic interleaving[1] is in progress.
> We also discussed this could be useful for memory tiering, e.g., when we
> want to move pages to multiple noes of same tier.
> 
> Extend the API and ABI interface for specifying the multiple destination
> nodes and their weights.
> 
> Note that this RFC is a prototype of the interface change for Bijan's
> interleaving work[1].  Hence this patch series is only implementing the
> interface part, not the real implementation of the migration behavior.
> 
> [1] https://lore.kernel.org/20250620180458.5041-1-bijan311@gmail.com
> [2] https://lore.kernel.org/20240408175228.91414-1-sj@kernel.org
> 
> SeongJae Park (4):
>   mm/damon: add struct damos_migrate_dest
>   mm/damon/core: add damos->migrate_dest field
>   mm/damon/sysfs-schemes: implement DAMOS action destinations directory
>   mm/damon/sysfs-schemes: set damos->migrate_dest
> 
>  include/linux/damon.h    |  29 ++++-
>  mm/damon/core.c          |   4 +
>  mm/damon/sysfs-schemes.c | 253 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 282 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 78745efafbb93197e476717385616ed57ea2df22
> -- 
> 2.39.5

Hi SeongJae,

Thanks for putting this patch together. Sorry for taking a while to
respond to it.

I am finishing up V3 of the interleave patchset using these patches. It
has mostly worked great, but I noticed that damos->migrate_dest was not
being updated in damos_commit(), so new weights would not be applied. This
meant that you could not update the interleave weights by committing the
damon state. I also saw that damos->target_nid was also not being updated
here. I will will have a patch fixing this with the V3 of the interleave
patchset that I will hopefully send out tomorrow.

Thanks,
Bijan
