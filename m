Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2160E14D28A;
	Tue, 23 Jul 2024 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721736961; cv=none; b=WPsVU75jUSQRqbQXfbx+4j+Xrlr86VEvx7Hm1N23AEUJbg9LYJ6ZqARpCtSgKdOpxrUmtTMRWWQS/2Pp10aJk6s5JLuYUGJyJ1DnzCyXb0P2xwtHF9IAg9SzFxpTyGJqDUx+Cst8m2pnnCdDfcv0UuTzBZ1xzbjob1t1r95Wlh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721736961; c=relaxed/simple;
	bh=GsauTDQRk0OPijEvOegqEpkfA+zhQq8Ca9baXNXV63o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OouLY+7yIzi+POhLOdlRSKBxjV03wiYQo5BAB6SJyRUyusggP55MgqtdT0wIKkbW1KAl/jVhH2RFNjjJ4VTMETvx43QdkWUuJZ3wF9F1TLVSHgTFQXl5WItJpIhX/9jOzRT3DZhGONVOoDBGq5Qs1PirJ9959veLGg3vni53TxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FU31NFMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FU31NFMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D087C4AF0A;
	Tue, 23 Jul 2024 12:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721736961;
	bh=GsauTDQRk0OPijEvOegqEpkfA+zhQq8Ca9baXNXV63o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FU31NFMSfZimcH5DCRUPdlNNIjZQMRwtNSiD3vRxXOdSRbIA8GnQWCUIboeumaGNk
	 BUWHftKLIs3kVfqSDrdiGXQzqze56b3HbAJD5l0fnEXlq+Se5uBybBdidvRM7C8b4m
	 vvm4v3uDCiVBwmaG1oVlsMlBrZD8Ru0S8la378Yo=
Date: Tue, 23 Jul 2024 14:15:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y 0/8] Backport patches for DAMON merge regions fix
Message-ID: <2024072335-gills-washtub-35a9@gregkh>
References: <20240716183333.138498-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716183333.138498-1-sj@kernel.org>

On Tue, Jul 16, 2024 at 11:33:25AM -0700, SeongJae Park wrote:
> Commit 310d6c15e910 ("mm/damon/core: merge regions aggressively when
> max_nr_regions") causes a build warning and a build failure [1] on
> 5.15.y.  Those are due to
> 1) unnecessarily strict type check from max(), and
> 2) use of not-yet-introduced damon_ctx->attrs field, respectively.
> 
> Fix the warning by backporting a minmax.h upstream commit that made the
> type check less strict for unnecessary case, and upstream commits that
> it depends on.
> 
> Note that all patches except the fourth one ("minmax: fix header
> inclusions") are clean cherry-picks of upstream commit.  For the fourth
> one, minor conflict resolving was needed.
> 
> Also, the last patch, which is the backport of the DAMON fix, was
> cleanly cherry-picked, but added manual fix for the build failure.
> 
> [1] https://lore.kernel.org/2024071532-pebble-jailhouse-48b2@gregkh

All now queued up, again, thank you for the minmax backports, much
appreciated.

greg k-h
