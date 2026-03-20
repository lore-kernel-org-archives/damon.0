Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF713B2FD4;
	Fri, 20 Mar 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019857; cv=none; b=Ufe3RVllwxMG+gBDOnireHm4wggBgi3B0WVZoqEgW0Y5X2CJKXjiMHviEqLWEX6Qhk9nS8MxfiLAaq9gOPObPB04nOvdsbc99YRIoYXqyY8+4YJnXd9dCK7pb73Og+GPSjEoSD+OD/RQyw9MBb+CoHx8AJ0WbG9zXYjTNL0zmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019857; c=relaxed/simple;
	bh=grkTVeJT4rKD+G/1Q+egwehQigyFRB+VPVj+azdo7e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPepaTnHOs0xpSjqR1BhAI9kjoR7B8j4nlfP2AZ0mL5IP4vVShP4aiDjmpMVKIt+hiVJnyKb7gqW5g6pLQATGf7KhqWqtM+GJ7CFQnYurfESYiWNYUTTOOULrcHqxQwEi1CKE+HgPLOkdUxVlnYkF7sad3dfRIbfYyj6d6pnWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAZHewiW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAZHewiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D489C4CEF7;
	Fri, 20 Mar 2026 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019856;
	bh=grkTVeJT4rKD+G/1Q+egwehQigyFRB+VPVj+azdo7e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAZHewiWExVTt/zyFbzLIdCJD/bpTcUx3fFXkZjbR6wKEsW7ip/YwFCzNC3CwykXJ
	 w5UpXWdWe93cL6g+gJP9CVwYzxK8GOTOvJ3lF6Wf0AI99wfokjkUr4VCd2AJBtj7AD
	 pa5VlsXzi8qcT9RN/YdnAypXmVremhTxo3nY7+Ttpxh1U/0D3oBJUqjmUzn2ju/SAl
	 6YEffy743Q1F9GS390x2hrnmTUIitsfIoIPLHulvQOHVVDK8kDbIn6CoF0Pfx8KynQ
	 iVY/NTMjmlGIlL3O8xkQBxLmSg5GkZSjX0JEmvcvLlPOD9x/FCx97QX8Gu/v4cDPrQ
	 hQJlnR4iloMjQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [RFC PATCH v2 03/10] Docs/mm/damon/design: update for context pause/resume feature
Date: Fri, 20 Mar 2026 08:17:28 -0700
Message-ID: <20260320151729.99156-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Mar 2026 22:21:46 -0700 SeongJae Park <sj@kernel.org> wrote:

> Update DAMON design document for the context execution pause/resume
> feature.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/mm/damon/design.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index 838b14d225193..e2e4fe3fb3986 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -19,6 +19,13 @@ types of monitoring.
>  To know how user-space can do the configurations and start/stop DAMON, refer to
>  :ref:`DAMON sysfs interface <sysfs_interface>` documentation.
>  
> +Users can also request each context execution to be paused and resumed.  When
> +it is paused, the kdamond does nothing but only online parameters updates
> +including resume request handling.

Sashiko comment
(https://sashiko.dev/#/patchset/20260319052157.99433-4-sj@kernel.org) below.

: This isn't a bug, but the phrasing "does nothing but only online parameters
: updates" is a bit awkward. Could this be reworded for clarity, perhaps to
: something like "does nothing other than apply online parameter updates"?

I pretty sure Sashiko is more English fluent than I.  But, shouldn't
's/apply/applying/' ?  I will update the sentence to "When it is paused, the
kdamond does nothing other than applying online parameter update" in the next
revision.


Thanks,
SJ

[...]
