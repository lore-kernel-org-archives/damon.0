Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6B4B0493;
	Fri,  7 Aug 2026 00:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786061608; cv=none; b=BxFGu7rpMZqTvIZUGcZjkg1zRbacHwzVW9RVU1BaG3dLAwzivAuXO8n0sdijAPsw5930Ic0aO9txnuOR5DJSBDky2rCD/lVPA1R6RA7J12EFajVRQtosV2RRYa+jhAUVDwymQZVzG1W/EpxvZKxUQkVQ4tvtmuMkgyQqYLAxu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786061608; c=relaxed/simple;
	bh=ppnEcyASbLcmTJuj6/jy2Sk3N14N3ndHEeYHC/JdwOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewEPwwS+s1qBp67ElMQXTh+Bc5Jp6ID9igtmNNjgf2/ZuQzKDDe0yqmQGxGdv18uGd46UjWq+zr+5NqrRDIyFIbdAu+4B3MknNmLyZMIrlSxn8Rq+nTn4Yg+kJHcvjkI3svY4swwtF5b+X2KvKS6d1vdeJIGaA2mSiaLPCQPeCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpfLwq0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpfLwq0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037641F000E9;
	Fri,  7 Aug 2026 00:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786061607;
	bh=SUkWc8IbxWpzQ33i0B//yTn9ol258cdEH2veH5fjFXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GpfLwq0IYZ2EU+OY40tvhxlCbR0jWJ+v9lq4b/ajtab0w/1FJlCD2pXLf4dAzrIkz
	 tMQdg77OZqxL8gidTxtjtfA3rVDlHJ+L90A4XlM2AzgFgZiauwYw8PEfgZ9ymEpy7f
	 OOOZVqjLihFImNY/mCJfI98wFH8xxMMuVl5EwKcJ9NPrmDy9FncN2ioqZW+bor32+4
	 K2Nbd96Uk+cFm5uFfXerMSHPIW/2LwH5bRZ+cx7cugj1DtohJVPEzE5ERz0KdTN9DF
	 hyu1gW5E1D7njul0HPjiGYAjvCYURYUpymz+78ZNoeddRtGDh9a4PPRDzR0h2RKe6l
	 8LMKAgf1k5caw==
From: SJ Park <sj@kernel.org>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] mm/damon/core: remove declaration of __damon_commit_ctx()
Date: Thu,  6 Aug 2026 17:13:18 -0700
Message-ID: <20260807001319.80491-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806170701.79266-1-zenghui.yu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  7 Aug 2026 01:07:01 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> 
> It was added by commit b1471afe4d10 ("mm/damon/core: do parameter testing
> commit on damon_start()") but is actually not needed.  Remove it.

Thank you for finding and fixing this, Zenghui!

> 
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Reviewed-by: SJ Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree.  We are now quite close to next
merge window.  We (mm community) want to focus on making mm.git more stabilized
and therefore ready for the next merge window, rather than adding more changes
that are not really urgent.  I understand this series is not really urgent.
Hence, Andrew might not add this patch until next -rc1 release.  In the case, I
will request adding this to mm.git after next -rc1 release.  So, no action from
your side is needed for now.  Let me know if you think this is really  urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
