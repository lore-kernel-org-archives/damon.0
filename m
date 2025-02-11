Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB81D63E1;
	Tue, 11 Feb 2025 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739257163; cv=none; b=mQ6WZMa3tyFi8k+OC+3LBbewtMYZTQTXAWfGCtZLpZyp86e44iDE0p8HntTNp+VwTStmgUQR9iOPrJIb+JtkcAN3tiEpZGJYwMGNzIq9CDkpQ9x9pZ+iHkbLfv91rfavx1XpY0mSzKI8lagydRe/dUSMfLeeJvTON925tPrx4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739257163; c=relaxed/simple;
	bh=zn03NYUWlorjpWcW8rYMRK7iAV7p3dUDfxQ2kfLiz0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S5/8/Q6dJZDcat/z2jxWpVSA5My3UpQqP9XhK6yHk6Cgs7zVM1Sq9eOXUvjeBlncqe2+XcgrNvdqFnLg6kNJPWRd+45E9WofiM+i4t4XtbNIeC6DbvnubZGVFQhfF3IG98X2t2Z6ousXc9gGipFeNDK0m68vkda3feWzUhUNJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZpKpCGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZpKpCGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25880C4CEDD;
	Tue, 11 Feb 2025 06:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739257162;
	bh=zn03NYUWlorjpWcW8rYMRK7iAV7p3dUDfxQ2kfLiz0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZpKpCGN/gwKCjVEwGWTHXWPnF82ODA84GaEvupijIwIXzW3AkFDN/jK0cyFFP+6p
	 yblmsX65KhyykSwLqdx/Drtr7JJ51ONxH44nmmp7oyHdC7xwmO0Nnsne4z3T45HYEU
	 D/6mhsZvjG2dJSX1W8swu8kYgxTCj98mnJ2m1qmV5tgBPi7aoKNx438wydZBYFFDib
	 r1RaoQhdYNB1AgI7qkHrCB24Y4WF29++tUFVl/Qvh6gi6JVnMB8zgn7yBmE+8ujrn4
	 ym+s5bKOIAR3BCEpgH002IjRMToHrI8nNch8jwhFvVP4AKL5N8C2on/2w7PO+98ve9
	 xi/BqOGhF0a0A==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 14/17] mm/damon: handle device-exclusive entries correctly in damon_folio_young_one()
Date: Mon, 10 Feb 2025 22:59:19 -0800
Message-Id: <20250211065919.5935-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210193801.781278-15-david@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Feb 2025 20:37:56 +0100 David Hildenbrand <david@redhat.com> wrote:

> Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
> we can return with a device-exclusive entry from page_vma_mapped_walk().
> 
> damon_folio_young_one() is not prepared for that, so teach it about these
> PFN swap PTEs. Note that device-private entries are so far not applicable
> on that path, as we expect ZONE_DEVICE pages so far only in migration code
> when it comes to the RMAP.
> 
> The impact is rather small: we'd be calling pte_young() on a
> non-present PTE, which is not really defined to have semantic.
> 
> Note that we could currently only run into this case with
> device-exclusive entries on THPs. We still adjust the mapcount on
> conversion to device-exclusive; this makes the rmap walk
> abort early for small folios, because we'll always have
> !folio_mapped() with a single device-exclusive entry. We'll adjust the
> mapcount logic once all page_vma_mapped_walk() users can properly
> handle device-exclusive entries.
> 
> Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
