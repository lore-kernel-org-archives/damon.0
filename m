Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0619BA5
	for <damon@lists.linux.dev>; Tue, 31 Oct 2023 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fnKeu2Xt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EFDC433C8;
	Tue, 31 Oct 2023 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698750969;
	bh=w8kgG/MgAOuluXb5mP0VQ+GKsS6sWg759ncFQ+iOEMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnKeu2Xt0bImvB+xP6CSqSUtvGO5Z4szF4LOtkSpmeTrxrCKKVHgqS/BgLpANNr38
	 dTCgIe+n7mmuxVB9vk2H1R1oI90/KQHrrvxT0g0Yk6C1F23UfJG0uLgX/FAZg2EL3P
	 DjnJnl+tpdLJ98NulIH9qGgewMB7sqsCrz3aJDes=
Date: Tue, 31 Oct 2023 12:16:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 6.5.y] mm/damon/sysfs: check DAMOS regions update
 progress from before_terminate()
Message-ID: <2023103157-rebuttal-directed-7f83@gregkh>
References: <2023102716-prudishly-reggae-1b29@gregkh>
 <20231028213936.45621-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028213936.45621-1-sj@kernel.org>

On Sat, Oct 28, 2023 at 09:39:36PM +0000, SeongJae Park wrote:
> DAMON_SYSFS can receive DAMOS tried regions update request while kdamond
> is already out of the main loop and before_terminate callback
> (damon_sysfs_before_terminate() in this case) is not yet called.  And
> damon_sysfs_handle_cmd() can further be finished before the callback is
> invoked.  Then, damon_sysfs_before_terminate() unlocks damon_sysfs_lock,
> which is not locked by anyone.  This happens because the callback function
> assumes damon_sysfs_cmd_request_callback() should be called before it.
> Check if the assumption was true before doing the unlock, to avoid this
> problem.
> 
> Link: https://lkml.kernel.org/r/20231007200432.3110-1-sj@kernel.org
> Fixes: f1d13cacabe1 ("mm/damon/sysfs: implement DAMOS tried regions update command")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org>	[6.2.x]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 76b7069bcc89dec33f03eb08abee165d0306b754)
> ---
> 
> I sent this patch yesterday, but seems not archived in lore.kernel.org.
> Sending again Cc-ing more mailing lists, to ensure it is sent and others can
> find it, to avoid any duplicated works.

Now queued up, thanks.

greg k-h
