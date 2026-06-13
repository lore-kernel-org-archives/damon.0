Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0ED282F01;
	Sat, 13 Jun 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781368805; cv=none; b=UoZRo8bW9BgTFJsK2P3neb1pxtugf/Tq5QYdxXofcUT3oRy94+p2HxzjCHsw9WvjR03ezjKamK07tUbLkWrzdSog+1dN5yDPbXfP/BqQIdGGGQSMiLU/Luwid65ljITFxhHxkY48qtBmV9BxcIkd+wMQFCQ1nj4mWXitETGPgs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781368805; c=relaxed/simple;
	bh=HdrJBYqH2xpxF/tlYtlXO3ILDvOeCW8EJALix0CTTfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sODbdCnvUCGuS/Lmtues830QZrJwGC9pVfmdhVj90r5xBKAC0egbq2/OglonLY6AC+FKb6WtEv1EOs+79DzAdvNbDiElaNgzEQGSZWNMEnNDJEBugNODxMS27oWuCrQfACGIUAllHRv2Eyzhvws6fsy7y6x2gvZYaRFR2Nckn34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAa1tCoU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAa1tCoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C94B1F000E9;
	Sat, 13 Jun 2026 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781368804;
	bh=vENOeEgj92DvKHrebEXNVsBUXjvDZ93gUKmK2SH4ptQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FAa1tCoUUlOHRm2cdnYs9qNxylH3M0i+GemVI1+Rm17fxJI8ivZuZA/3XjG+Np+Ir
	 ttrpFidOqsieNIM/FAQFcD4ZywhqD7UowcxD9wJySrLPpxfjg2rPAJnW1t8MLfgGxH
	 0iMA/pVVn4ABPFcUmHn6RJKHXvl18G8jj1jK0x4ego7KJS1a6aZ31Vl9VuXBJn3Xuk
	 vG/cYi2trBpb918LDsr/8eFknOEuym8K7xGCSs9hihzHH5ITpXTWTrxqvJX5iCSazB
	 GQjPSq3LnTn4f60G6Pw+GOp28Egi7h6g2V49Pp6GlBcd+cGbmGqsNmQm1+KFa/ojGM
	 sErfbHQDD6y0w==
From: SeongJae Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Shardul Deshpande <iamsharduld@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joe Perches <joe@perches.com>,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH] treewide: fix transposed "sign" typos and update spelling.txt
Date: Sat, 13 Jun 2026 09:39:56 -0700
Message-ID: <20260613163957.2441-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4072c971-0a54-4bbe-8cb1-c06e13b22f05@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Jun 2026 10:32:43 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> On 6/13/26 8:07 AM, SeongJae Park wrote:
> > On Fri, 12 Jun 2026 23:46:32 +0530 Shardul Deshpande <iamsharduld@gmail.com> wrote:
> > 
> > > Several comments and one documentation file transpose the letters in
> > > "assigned" and "unsigned", spelling them with "sing" instead of "sign".
> > > Correct all of them.
> > >
> > > Of these, the misspelling of "assigned" is not yet flagged by
> > > checkpatch, so also add it to scripts/spelling.txt.
> > >
> > > The remaining matches of `grep -ri singed` are RISINGEDGE register and
> > > enum names, not typos.
> > >
> > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Shardul Deshpande <iamsharduld@gmail.com>
> > > ---
> > >  Documentation/mm/damon/design.rst          | 2 +-
> > >  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 2 +-
> > >  drivers/gpu/drm/drm_color_mgmt.c           | 2 +-
> > >  drivers/scsi/elx/efct/efct_hw.h            | 2 +-
> > >  drivers/scsi/isci/host.c                   | 2 +-
> > >  drivers/scsi/isci/port.c                   | 2 +-
> > >  drivers/scsi/isci/port_config.c            | 2 +-
> > >  kernel/bpf/helpers.c                       | 2 +-
> > >  scripts/spelling.txt                       | 1 +
> > >  9 files changed, 9 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > > index afc7d52bd..899ac9c69 100644
> > > --- a/Documentation/mm/damon/design.rst
> > > +++ b/Documentation/mm/damon/design.rst
> > > @@ -140,7 +140,7 @@ as Idle page tracking does.
> > >  Address Unit
> > >  ------------
> > >  
> > > -DAMON core layer uses ``unsinged long`` type for monitoring target address
> > > +DAMON core layer uses ``unsigned long`` type for monitoring target address
> > >  ranges.  In some cases, the address space for a given operations set could be
> > >  too large to be handled with the type.  ARM (32-bit) with large physical
> > >  address extension is an example.  For such cases, a per-operations set
> > 
> > For the above DAMON part,
> > 
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> This one has already been fixed in mm-new. See
> https://lore.kernel.org/20260520012104.93602-3-sj@kernel.org .

Ah, you're right.  Thank you for catching this!  Please drop the DAMON part.
That said, now I reviewed all the rest parts of this patch, and all look good.
Please feel free to keep having my R-b: tag.


Thanks,
SJ

[...]
