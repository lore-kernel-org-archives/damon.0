Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E328395AD8;
	Fri, 11 Sep 2026 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168763; cv=none; b=ljT9s0nWfLJpVTh+ZrRnsQQCK3GGlJDTJWVEPzNQR9SUJ/1rvStDmJUwKZfBS8SyKsK5xMNmiZXF7rYHFbAXu2yocz6dV1Ygd3ZKG4IvE111Z05hl4z4Bl+IwJC+e6kAbUhjCFVBIVtwHnvSft7EUgdqgSSujtJSVzkkhjCpI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168763; c=relaxed/simple;
	bh=jVnVr3lky0mh5aO/MnT1M8vzhWIdcaZMbVWjxPSQAx0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rhV+kuWucHYnXfEQtLhefcXOBBDdM4Yo9A0QiAZ7hw2a5RVpdfun2vZ1gGq68EG3bwvzEzP//y+mxeyorBOkIulEOFgzsCqNQVh3CvgvMptLXqtGvTDI5KY3KFkJ246wTHhs4LVwukH0WonFNha+ffOSLNXjjoNda4Vb6SW4k4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=efyncMxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="efyncMxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA421F000FF;
	Fri, 11 Sep 2026 23:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789168761;
	bh=2dCaD2vcbQEeBz2ghBZutu/cWiXceCvmimerL3kOqdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=efyncMxMVA2gZzm7iQT0ijkIkYkV4JhN0RbqG68ZR7QV9Rm0avxF++ne4Q26ICSlu
	 GoJa42aS4qGzV2f5NkWGKw4VWQZPoILKksVe/o0qyBWJZZV5NqE5ewSY5MMNZEeRvg
	 Tq8N1mSNEYYisEk4YCeVWFn/JluVs4GHCl+nwMoo=
Date: Fri, 11 Sep 2026 16:19:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes
 <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, damon@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/7] mm/damon: introduce probe_hits_wsum DAMOS core
 filter
Message-Id: <20260911161920.dab281d16d9fe9c0e3947404@linux-foundation.org>
In-Reply-To: <20260911135510.96914-1-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 06:55:02 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON can do flexible data attributes monitoring.  The classical data
> access monitoring can also be done using the attributes monitoring.  The
> access event is just one of the data attributes that DAMON supports.
> Users do monitoring to make some actions based on it.  DAMOS is a
> feature for automating that.  However, DAMOS cannot utilize the data
> attributes monitoring results.  It is still Data "Access"
> Monitoring-based Operation Schemes.  It requires users to set the target
> "access" pattern.
> 
> DAMOS core filter is effectively the same as the target access pattern.
> It is just a more generalized and flexible way of describing the
> operation action target region.  Introduce a new DAMOS core filter type,
> probe_hits_wsum.  It specifies the filter target based on a range of the
> probe hits weighted sum.  Using this, users can apply DAMOS actions to
> regions of specific data attributes pattern.
> 
> Note that the classic target access pattern still works.  Hence the
> target nr_accesses range should still be properly configured.  The new
> filter would be used in only data attributes-only mode.  In the mode,
> classic access monitoring is just turned off, and therefore nr_accesses
> of regions are always zero.  Users could simply set the target
> nr_accesses range to include the zero nr_Accesses regions.

Thanks, added.  Along with your -fix for [1/7].
