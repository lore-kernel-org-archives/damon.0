Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4A3D3D1B;
	Tue, 15 Sep 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484477; cv=none; b=IhKaNUV5khK8URJqhWHibqNI3Xg2m4MfbuLPptQ6r58sqmkzbgjIgV9/5NuWmsKIFWBUqwsXYqY+NuKCf39Yw6RqVwKnz8U3d4+TsFrCUWCZMu6ZsLPuKqOJSmyESvr9rVGerlMZ7aTLDeKsiuHkXHT8l+GztFg5HrQNGeFAK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484477; c=relaxed/simple;
	bh=pnCgJ005A0F382b1YiQWITRvvDLVNp9MYphGYRRc7cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXclE639u0WzpkgS7l2Rh1CsEy3fvlHCZuSuBjbNybytzX1c0G997cKmcohh9mCKDga9qwznVplme+liwU8S2IZAx0SSq9qkIoBsprCkKczKE+qK62rAVmOULdjKne8zbUGwixxUCYL7gGPeIK/bTdFAbo0cd7EZt5g65XRzVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHcx8bnB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHcx8bnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA671F000FF;
	Tue, 15 Sep 2026 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789484476;
	bh=0sDh1qot9myjlJ0S89pmLSsamlOt4QuZGlDO+V25QSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QHcx8bnB+zWYSYQJXQa6gb6cMnklCxMh3CDVE6sNIAaUHY+fkSAonWzkCHNn0Y6u0
	 MRxU/qI3XJtc9S2GxTGFlB4mWY5PjbAaYIvusoLnYRUNw5FoA1Sb7/9ZJ6pgJ5w+QS
	 W4AnEZrEsJdbuJ6lPwMSE+Z9P5JgcDRll7KrHfZG4g56Zi1TVL2/NeO1C4p/tNEnWJ
	 YS1qR/EkOJtbmHTeLH3vYgPYUpQdejrkIIzGFHvAL/nCN/bobQAegL1RNeTze4RNPQ
	 57A8AKYjfjJ1ZaD7Z2/JSoUmngr+JfMsVTXnu8hU6H33lcaknrnsu3OZhCzfT/937O
	 ItkL+2ikxpVWA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 7/8] Docs/admin-guide/mm/damon/usage: update for hugepage_size
Date: Tue, 15 Sep 2026 08:01:07 -0700
Message-ID: <20260915150108.92484-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915143359.91472-8-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 07:33:56 -0700 SJ Park <sj@kernel.org> wrote:

> Update DAMON usage document for the newly added hugepage_size data
> attribute filter type.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> index d3e37400367bd..6b80bce5d678d 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
[...]
> @@ -308,6 +308,8 @@ Writing a number (``N``) to the file creates the number of child directories
>  named ``0`` to ``N-1``.  Each directory represents each filter and works in a
>  way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the filter
>  ``type`` is ``memcg``, ``path`` file acts as ``memcg_path`` for :ref:`DAMOS
> +filter <sysfs_filters>`.  When the filter ``type`` is ``hugepage_size``,
> +``min`` and ``max`` files acts as files of the same names for :ref:`DAMOS
>  filter <sysfs_filters>`.

Sashiko found a grammartical error above.  It needs 's/files acts/files act/'.
It is too trivial to respin the series in my humble opinion.  Andrew, could you
please do that when you pick this up, or let me know if you have different
opinions?


Thanks,
SJ

[...]
