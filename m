Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0693F6C3D
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050784; cv=none; b=YmctpvlYPczNljpxFDkkqD4qxTyBco8oeBpVNU3ZY68pP9NmInIg1tVaY2dTBYDdacW2+TmRM08keShc1RMgwXGreOGMABKYiSihJOzdUHtEJZGAbaiJPYBrD9ic7OXw/YBFqohB8T1Amd5Nyol6aDIBTMc0vtuDmqkQ4H1quPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050784; c=relaxed/simple;
	bh=L4hlmakTiqe9cL8TIkzuSuwhhInTalAmvO7l3MWINWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhv2kVrL13qhxgk1Q6gyRPLhmdR5XXZO7gFop83CewRbSiPeT7G7UZ7yJs1ZVgBq6Z+XJTM9kdtOkE07ehd1656Z9c1z5rq9rHyeLNdM9PBuwl0Uq2dl3Nrv7PwiHDJ1Rfr3XI17aafiKagiRsD1xAiDKPX+PH2UFmu4dztWH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhPpgDTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhPpgDTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3121F00893;
	Thu, 10 Sep 2026 14:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050781;
	bh=gUyA0RFY0vbfsAtw5n5iskyohSUXdwNuc7jGsdTDeI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bhPpgDTrLKD6pJ1n0FZ9cy2NIqbLlbi3NKvfkMOWPvhjK/aIe3qfMjcD7oUsx2wbS
	 FA1Vz3OrxP+I4uNO31+DNIswxWb07RbJrQJCpwC6h9XJF5bJm+CrWTPRN8PP1lxBCb
	 +1s0gLZwMNOGZ004UWwm4uL5KyP1iF5sxbc5xWF7j/6ANiDKijLY/5gIPCR0pNHCKY
	 dDW+J8MN3bJl6QqYEZOze17Zvb/qV7QrwnI6Ge6h5B4Z5bFIfDzhVOz4iVNcL93TZq
	 bZV2vBNueYE71P8R13OiNb0T5G5GB1f1PFumiGOyfv1A1efactd7HdjUoMRyRYcTMc
	 uLJTr7JthkQIQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/7] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Thu, 10 Sep 2026 07:32:52 -0700
Message-ID: <20260910143254.173561-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910142717.916D11F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 14:27:17 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The kerneldoc comment for `enum damos_filter_type` leaves the handling behavior of `DAMOS_FILTER_TYPE_PROBE_HITS_WSUM` unexplained and contradictory.
> --
> 
> commit 78a988db300660b08e965cf2117e7ad015861252
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
> 
> This commit introduces the DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filter type
> to allow API callers to target regions based on their probe_hits weighted
> sum. It also updates the damos_filter structure and associated
> documentation to accommodate this new filter.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 871d26adf6ae5..ef99ff778ae10 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -399,14 +399,15 @@ struct damos_stat {
> >   * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
> >   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
> >   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
> > + * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
> >   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
> >   *
> > - * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
> > - * are handled by the underlying &struct damon_operations as a part of scheme
> > - * action trying, and therefore accounted as 'tried'.  In contrast,
> > - * &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET filters are handled
> > - * by the core layer before trying of the action, and therefore not accounted
> > - * as 'tried'.
> > + * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
> > + * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
> > + * damon_operations as a part of scheme action trying, and therefore accounted
> > + * as 'tried'.  In contrast, &DAMOS_FILTER_TYPE_ADDR and
> > + * &DAMOS_FILTER_TYPE_TARGET filters are handled by the core layer before
> > + * trying of the action, and therefore not accounted as 'tried'.
> 
> [Severity: Low]
> Does this leave the handling behavior of the new filter unexplained?
> 
> The newly updated kerneldoc for enum damos_filter_type explicitly excludes
> DAMOS_FILTER_TYPE_PROBE_HITS_WSUM from the list of filters handled by
> operations, but it appears to be missing from the subsequent sentence
> detailing which filters are handled by the core layer. 
> 
> This creates a contradiction where its handling behavior is undefined. Should
> it be added to the second sentence alongside DAMOS_FILTER_TYPE_ADDR and
> DAMOS_FILTER_TYPE_TARGET?

That's described in the design document.  Maybe we could add more documentation
including reference to the design document.  That could be done as a followup
rather than blocking this patch.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260910141849.170896-1-sj@kernel.org?part=1


Thanks,
SJ
