Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2821D3E2
	for <damon@lists.linux.dev>; Tue,  8 Jul 2025 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940118; cv=none; b=iIqN9biZIfYtEDgyrN1bdCo7Nl0e5VMUphamUhJCHNFEOJ12Fy8w27z1SO4CVCQYMnLVUaGJF92+vtY5me83U/672RK3aeFR3V38AENtk+WUFBxMsXl1gOgqTAwY/GgpFbe37Lj4R78cXPjCAld+Oys03LhANp5AsU8fZS3AOCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940118; c=relaxed/simple;
	bh=YdaGsOPHYfI98+ga2BXa1W/Dyli19ovtNxGAhh1PQ1E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rmySrNCpCcG3Xa6wXQgFu4jysRHFKbEUzgcYnjV3/iBqYOMA14X63fuKlKMbZam6xgEGyULlegL0IgRfxil+xrd8kGHGuIRNAMbeDp4ccSispuRoyyy6R6VT7aL3gOm/87r+s9Y+5ynYwqBs6H+oQ1tjLQ1rD6ymP6ZIGvkdC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NtumUQqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NtumUQqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D5FC4CEE3;
	Tue,  8 Jul 2025 02:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751940118;
	bh=YdaGsOPHYfI98+ga2BXa1W/Dyli19ovtNxGAhh1PQ1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NtumUQqC3qq2A7K28IEPUpD5B8Vv1RD7HzqVbZRHFR4RWVaCWK1M8luRpnYyTvYRu
	 3JzKVsbLge0LdadUbbZ0bmMqROmEDNq3wZkRY24ugSsuFD7SOYijNvLPZRA67B+yrl
	 sk8lXYyq2Bjq9/0HjbFClNFpHg/8/L6hJOgF36Ac=
Date: Mon, 7 Jul 2025 19:01:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [PATCH mm-new] samples/damon: change enable parameters to
 enabled
Message-Id: <20250707190157.e9022f001e5141e449634a9f@linux-foundation.org>
In-Reply-To: <20250707161536.85426-1-sj@kernel.org>
References: <20250707024548.1964-1-honggyu.kim@sk.com>
	<20250707161536.85426-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Jul 2025 09:15:36 -0700 SeongJae Park <sj@kernel.org> wrote:

> > There is no functional changes in this patch.
> 
> Looks good to me.  But, I cannot apply this on latest mm-new.  Could you please
> rebase and repost?

It applied cleanly for me.

> > 
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Added, thanks.
