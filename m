Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B68287E;
	Sun, 17 May 2026 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779007535; cv=none; b=ZiPiYuyGReiAfucE+6xxb3uEvaeNQe5WPKJBvNYRI5LaVIv8s0cVRrQdO0hXwZuOS8PunxjzP7/Dm6m0CykavKIhB7YDjotcjmKFfJ/T4n0r40XOIm2aHkCJmRsEiKRAeOddeqPl6ESNWRerakpKAozDYrsMDDhU0UuBx63vXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779007535; c=relaxed/simple;
	bh=LVzeahNDHZ1WvAmPSQ8GPJ8xKeGAguvAQRUr2DznCm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3CxnOEBAzHONvQGa3TFr07iI6nxaguBzu9Xs9XJtGfN/qTDmEwWQ4Xp/TItT7MNFS8HyDvVEtdcgLQm4ZXKAqQcbvVds/iLmpxKSjXaKnPE6hG6+Wf1MwopKtbBXIT7GPAvqqTUq5Oyx/ZcHsu8zw7aAiEY7XmQq1g35mDsJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaCdPL4f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaCdPL4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EB8C2BCC9;
	Sun, 17 May 2026 08:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779007535;
	bh=LVzeahNDHZ1WvAmPSQ8GPJ8xKeGAguvAQRUr2DznCm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaCdPL4fOfAkwVPsyjkMALDCbw2efJ9jdDmWVk6urIWoAhsRIpVsbYQcYBxwmwZ1Z
	 ofKhSjKK7d2I6+NtrQxKNccw8MlYhKWdmtyW7vW+cpdKxWCV9YCI/dErQEiDSinBF+
	 cuSbEXZd6WkNvLuQkf5SkDUVzozx83ZSP73oOrmtjz2+jmi14cz8QU2/GP7h7v92Xz
	 hvyU/GXrUf1hpT6HHRAVY6Dvx1bgORLRJWJL+kQLWeeED/FvHWK94EZlWsQ784hZ+8
	 OM2rCDE4V8yPdYxugG36yJb8Xf3kvCdoeZ+zFErIMKyxvlc2hyWkPjpNA+RCvEjwPq
	 WO3HEVNTXABVQ==
Date: Sun, 17 May 2026 11:45:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Sakurai Shun <ssh1326@icloud.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] design: fix typos in design.rst
Message-ID: <agmAJnMaRyyd-MEc@kernel.org>
References: <20260517073433.3015-1-ssh1326@icloud.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517073433.3015-1-ssh1326@icloud.com>

Hi,

On Sun, May 17, 2026 at 04:34:26PM +0900, Sakurai Shun wrote:
> Subject: [PATCH v2 RESEND] design: fix typos in design.rst

Please use more descriptive prefix next time, like SJ suggested
Docs/mm/damon/design

"design" is too vague and gives zero clues about what subsystem it is.

> L140: "unsinged" -> "unsigned"
> L371: "sampleing" -> "sampling"
> L387: "multipled" -> "multiplied"
> 
> Signed-off-by: Sakurai Shun <ssh1326@icloud.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  Documentation/mm/damon/design.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Sincerely yours,
Mike.
