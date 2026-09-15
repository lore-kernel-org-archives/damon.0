Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40B4DB547;
	Tue, 15 Sep 2026 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515571; cv=none; b=hO99QNDyyi0VDIsmYQa8+JWT+CTe/MW9V6akP9lh4KZ+Ai4QulmMJeHzJ0gYl8I86l4gr/nKsEk9OsqkcZH40z+mWtbojevHU58a0OTN+GPHCySosgxnvIZhCjVqW4cB22k+zmQB+WYrDgJ6Czy+jn/q0AzxKxR1rPlh/AKJWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515571; c=relaxed/simple;
	bh=cBmzsGH8/A1iaHTmWPrlLf2myh+niSK2c22kmFiWMjM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mQ2+xcw/6W4vt6/6JXOjKEybs6aPg8iTiRDqgh7Kq2yoVrgaJOZdXi7YF4FWc2LsW6Qb84MfjWzkB9GdhivtOLkvaH5W/+fG1fp665Bxo86czbQybdL0TSxYCenvsgrkm4un5WSmauXoE2r6J/1rVXiJbuna8HasX03I3oybk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oOejxibo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oOejxibo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392231F000FF;
	Tue, 15 Sep 2026 23:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789515569;
	bh=4m6z6CRskb4Hb1ZLGj5f4sRG4VITlSDdQKTs+jezx5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oOejxiboHlvkVxPn0NeFBbBeevJUCag7z37xbXN/w5CIeoOvk835Wv/hOl+kA09z5
	 i/mlUtuf4DlVmbIU5a4h5a2m9HWWRGSffdZdgKDJNYzH+ub5cE8X3+zCtjGERAyTau
	 RgyOda1PsB32Ob5dwbCdraALkMRWVwi14wMuRh78=
Date: Tue, 15 Sep 2026 16:39:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes
 <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, damon@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm/damon: introduce hugepage_size probe filter
Message-Id: <20260915163928.9d6260f445d895429d115fd8@linux-foundation.org>
In-Reply-To: <20260915143359.91472-1-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 07:33:49 -0700 SJ Park <sj@kernel.org> wrote:

> Knowing whether a given memory is backed by a hugepage of specific size
> is useful for efficient utilization of hugepages.  For easy monitoring
> of the information, introduce a new data attribute probe filter type,
> hugepage_size.  It works similar to the DAMOS filter of the same name.
> It works for memory that is backed by a hugepage of a given size range.
> 
> Patch 1 introduces the new probe filter type to DAMON API and extends
> related data structures.  Patch 2 updates probe filter commit logic to
> handle the size range.  Patch 3 Updates the filtering logic to support
> the new type.  Patch 4 adds new DAMON sysfs files for the size range.
> Patch 5 updates DAMON sysfs interface to fully support the new filter
> type.  Patches 6-8 updates design, usage and ABI documents for the new
> feature.

All queued up, thanks.  With a -fix for [7/8].

> Test

fyi, I'm always reluctant to include testing info in the permanent
record.  Because it's development-time info which becomes obsolete very
quickly.

It isn't useful to someone who is reading the changelog in mainline in
2028 (or even Nov 2026) because the patchset will have had far more testing
since these words were written.

It is of course very useful info but I suggest it be maintained below
the "---", where all short-term development-time info is best
maintained.

