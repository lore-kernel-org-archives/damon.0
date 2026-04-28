Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90409306B37;
	Tue, 28 Apr 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387718; cv=none; b=TD4ulo1U/hgdV5hFNcDmmn1CoMXWU3DAygtA/YGxo7MCz6FlO71D5XbEWxX/GaOVKFeACRscxKXtE2YUcGXpEEZstLMtMeTicm0QkamhXt3mijJqPKQ8zAkScIbcbVS1a4TnAxRHg4enmV9JOY7MLJVR0i/H9m9h40jB9x6IRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387718; c=relaxed/simple;
	bh=fl4uPnTzPtt7hgrrDvSXu3usBjSgMiPtMXIsK626XNs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iykTl+k5CIkK/xTqt+g04qRyTwQRmyXLDSZb41UNRyE388ALMN9XTCU5m59Y4Tag05qYgiKpZVIUzliD29hv5F/V06woKkkDMUnh+pbZXz0XPhH63H4vLxlt11acYbQXOBxFDNx2sK/+q5Au+5rHac0KJguzPd/bB++pn/TeTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HNS7/b+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HNS7/b+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97411C2BCAF;
	Tue, 28 Apr 2026 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777387718;
	bh=fl4uPnTzPtt7hgrrDvSXu3usBjSgMiPtMXIsK626XNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HNS7/b+XCNrPLUcOE8F74Z3u6L0t/ABy5MsW/bWl3De+y631/5mG2Sr9RMq2naZ4Q
	 oezo2lNAPYgOn2Mi/NyKyuwdvSz+Y4tvLNY1XWpcgTDooYql4J/q5E471TYxLxfrrG
	 i7HzdoUPkZkRE8WjK24HiUoR2P0eORdhoZerDlzc=
Date: Tue, 28 Apr 2026 07:48:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@davidgow.net>, David
 Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo
 Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, damon@lists.linux.dev,
 kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 00/11] mm/damon: introduce DAMOS failed region quota
 charge ratio
Message-Id: <20260428074837.5fb02e0210ebabf160506a80@linux-foundation.org>
In-Reply-To: <20260428013402.115171-1-sj@kernel.org>
References: <20260428013402.115171-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 18:33:49 -0700 SeongJae Park <sj@kernel.org> wrote:

> TL; DR: Let users set different DAMOS quota charge ratios for DAMOS
> action failed regions, for deterministic and consistent DAMOS action
> progress.

Add, thanks.

As mentioned provately, Sashiko claims to have found things which it
didn't see in the RFC.

	https://sashiko.dev/#/patchset/20260428013402.115171-1-sj@kernel.org
