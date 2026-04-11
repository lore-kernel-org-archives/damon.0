Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB483845A2;
	Sat, 11 Apr 2026 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775933504; cv=none; b=DrXy4ia+hxZeRPJY0UPbVh8QqxQj4nfKylZ/LKs/nd5hsGWnSL7ppCgAR84N7oyjGOlt5uyYktiFXDtSyXbXV2QZWYmcqZ/sqTFRk25Oe//kbQ5GKaBy4RKD1Mx4HBCE8tIPPL+/g31bBjjdKyez+KnCENCHBJbxlPO9BjtRJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775933504; c=relaxed/simple;
	bh=7DTLn03lS5fHMMRHZwemH8MHnpoXTwRp/xjThTiacFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG8yNVl0QiVcOnzH9tHMkssniayyiEe+h+WbP9j7I0x9WBOGAXMmi289mbre/duYjF2n0JUD16K4IYkxecxFn3w8e7ORYuys0+6Wy47Mv09UxHharUhCGf/CDdWApEyKQBRB/XU2PgBvqshhzFWgvyUbSZnuyuIaD3aAVsUKoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjbiR7UG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjbiR7UG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EB8C2BCAF;
	Sat, 11 Apr 2026 18:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775933504;
	bh=7DTLn03lS5fHMMRHZwemH8MHnpoXTwRp/xjThTiacFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjbiR7UG+2oFW3xlBlmFGKjzR6oX1qGZUkBLQvDLpNRpd5rTI4k0QNQmCbO7hdgOh
	 hnTxa0ZcZBx4gnnirFuBDi0gVMWqFpMpCVPMHyoNUfOMVYXCMjhX1sU/x4bU22xw2A
	 9s9x/wX+TCrRrapOrZCoSdc4cQswo3T3D1VWORidDzjib81hUeN9OJ06oomTCtch2Z
	 X/30t1hebjgCO/vEOhJmRfhQnS/Dzo+KMRQawPw8TW9JG7KRuxr/igVo5f35HslsHy
	 QqKEZPArl2JsVTsegtCZAbJIg0GNkbwilaIwpzeRa1+dxa5I64q3NXJBhYc44WKLvk
	 xK/UnqrJXASnQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] Docs/mm/damon/maintainer-profile: add AI review usage guideline
Date: Sat, 11 Apr 2026 11:51:35 -0700
Message-ID: <20260411185136.82032-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411184802.81804-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 Apr 2026 11:48:01 -0700 SeongJae Park <sj@kernel.org> wrote:

> # sashiko review suggestions
> #
> # 1. Consider reducing recipients.  Maybe the author,
> #    maintainers, reviewers, and mailing list of the
> #    direct subsystem and parent susystem mailing lists
> #    could be a starting point.
> # 2. Add short summary of your opinion at the beginning.
> #    For example:
> #
> #      TL;DR: sashiko found an issue.  I will respin.
> #      TL;DR: sashiko found no issue on this patch.
> #
> # Please DON'T FORGET removing this comment block before
> # sending this!

I forgot following my self guideline above.  Sorry for the noise.

TL; DR: sashiko found an issue that better to be fixed.  I will respin.


Thanks,
SJ

[...]
