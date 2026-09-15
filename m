Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB73CEB98;
	Tue, 15 Sep 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437627; cv=none; b=Au17F1Lp3XUgtWDJjwxhLJ5i5JEpuOrwx9whUmIAcfIB8wAPsUK+CencO7byUvD8zdy10V6GcUzgWlFeSfNg8MnDqecKpwUEaatyijp8kLRZzDkrE4KbkuZoWaW/ehj6Z0oJ3PXGWcUndSK0/tbQVtMwO8hiktW9k5PQnDZCGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437627; c=relaxed/simple;
	bh=6fRVEXV2uHngOQepnlsDfQPT/CwZLG42dPNSEGi78xY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Llj0OVVY0Hmf+vWmkzbDXJbthtq+VL34HEPSoUulhyA4zyGzOpwX5k+8jjUCKwdbkywbMML9f/SkIq62UgNJLGWmC3OxE71G6oxIwgsoldRaNflZcfQe9lBDnQYB30H0Fb5OJ6uDIgALCd+BC0yadITW7IKhfCpjzNliS+GWr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AsWED0K5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AsWED0K5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8B41F000FF;
	Tue, 15 Sep 2026 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789437625;
	bh=seOLtn7PZjOcFpj74bjwxSYEG88tNO9Fy59lprCxUnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AsWED0K55GRxQa+2by8CN/aH5Eu+FIzfpnhXxCbY7do0WSyI9wDy8wdp12TmIvIVg
	 qlc7+DhAH2ZkbQ/cirw5BQZ/x/H1cFkRq9pkxmXbQLDE/6pcDGQO+LZjR+plypPG7b
	 o6d6oDlH/NV09BN1XhW3tamrb6bbP+TOeoflg+aA=
Date: Mon, 14 Sep 2026 19:00:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <davidgow@davidgow.net>, David
 Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo
 Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Sang-Heon Jeon
 <ekffu200098@gmail.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, damon@lists.linux.dev,
 kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 0/6] mm/damon: misc improvements in tests and documents
Message-Id: <20260914190024.358f167aea301b78d50e6a00@linux-foundation.org>
In-Reply-To: <20260914141952.91465-1-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 07:19:45 -0700 SJ Park <sj@kernel.org> wrote:

> Add various improvements to DAMON tests and documents.
> 
> Patch 1 and 2 from Zenghui Yu (Huawei) let DAMON selftest to clean up
> its state and output after running the tests.  Patch 3 from Eva
> Kurchatova makes a few selftest be able to run with Python's safe path
> mode.  Patch 4 from Kunwu Chan improves coverage of DAMON kunit tests.
> Finally, patches 5 and 6 from Liew Rui Yan clarify and fix typos on
> documents for DAMOS quota behaviors.
> 
> Below are notes that can be removed in the final commit message.
> 
> This is a batched repost of DAMON patches that were individually posted.
> Please refer to each patch for changelog.

All queued, thanks,
