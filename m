Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4351DAE9;
	Thu, 15 Oct 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074075; cv=none; b=iOfFEsJ80FhWwdMoKk4asOHLRZ/9mgd7hqEjAwO7a9lYvWW86pAZX7hq2Ie8oz8NbscY3ud6AJ4fwkkb50HsJWwv6MTMhJ9shTIjwS6TnzdxqES9xww7GhAo2qIOJZRneHspRVjTw//bX9sXAV0AZxVD+SVlNv8ur/JXDe41Wdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074075; c=relaxed/simple;
	bh=OGLWK2i4tyy01NrVOUTFbTD/AssiMrryALEbzMmap/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY3ld6cWUijBiQKVFRjmbn2mSoywWBFzGLyS+3+Vh0LSCiGpLxpRTSk6uUCBN8MKmEl+4A+FVLQvVJsfim9gOliN+ojgA/68Lv1NxWHV9h83c5BlMqS49Glfo8QB9eJcKfBLCn1rSwo3MHQlRqWY8grpfZAyMFS3hpY2rMma35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9GoNncv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9GoNncv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0081F000C5;
	Thu, 15 Oct 2026 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792074073;
	bh=XPbwiAj/U5jx6Paywkr8oSvS8UbuCkW4wBewY//2I4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X9GoNncvd9RH3tnjSeWzXZ+qQNiclD7IapaOh/bPNX9c9/FmzNLZ3A6SBNmUHmhRY
	 6WzWEtKlpG66ObUQ7LIBRD5Z0gw0K01KRuDrD5CAZ2JfKslJHemc2p/0MLhTrjefT6
	 nBJpyMvPoGaMh9ZOr89p9+KwxsczCc+Oc70D35Yl0Zrag7JuTn17SwtLEb7L0sDzYI
	 2xovEwpGard1NaJTD029REt4Nc5NVXpy9ZpjhjuhhGTPpSZsRVVPTTpCWPaEWvhc+z
	 F6VEHjbUf72KosxM63gY0mTiCwSgnARCT82IHiIxRh4KVZQyPmOeU4r2IE3s4HCGKK
	 g0WGV/Nt82+Iw==
From: SJ Park <sj@kernel.org>
To: Suhaas Joshi <suhaas@s-joshi.in>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/damon/core: Use only installed probe in damon_merge_two_regions()
Date: Thu, 15 Oct 2026 07:21:06 -0700
Message-ID: <20261015142106.102721-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015135801.19326-1-suhaas@s-joshi.in>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 19:27:53 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:

> While merging 2 regions, we iterate over the entire probe_hits[] array,
> whose size is determined by the DAMON_MAX_PROBES macro. However, it is
> possible that we have fewer probes installed than DAMON_MAX_PROBES. In such
> cases, we end up making redundant iterations. Therefore, to remedy this,
> iterate over the list of installed probes instead of iterating over the
> entire array. For doing this, start accepting a struct damon_ctx in
> damon_merge_two_regions(), and update calling functions to pass this
> argument.
> 
> Update the damon_test_merge_two() test to use this new signature for
> damon_merge_two_regions() as well.

Looks good to me.  Thank you for this patch!

> 
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
