Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146764;
	b=Of2mopPgybk2vL+dfd0s1JrgNtqxDTROvL78JQ5M2eShL6PFuba+6s14LspcixaQXrkg
	 imuezeyK6fbCAVKcvgLVDcYsg52MZVX7L7Qdh8t6Tx9Z15uthfPw4DgKab8HvUrKmOl61
	 qpoHtuL+Kjy9Njg6K+pDaHk7yLK0wPL3hAxX3lylmGftYylyEaFx1td+D8gyL2RadEEQt
	 MF9tunczfNuafBQtIv/fUs3Lor/syJMX46/+RlLS73DiggyKkVm8pjnv+SVTs/9sCkfco
	 y3WcgFddAFCruu58u60Hm3IetYSPLdBPDqCUIDcX7kYjlSz+NNEsN9FVHBGdTYhPAfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146764;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Of+Ihfq2JolsP7lQDuT/aMXMnMjzwRQu8EA+8gWaGVg=;
	b=nMfd2/dUYenWmjdqoyRzPF+HqWQR3cDwxKsiBqfj3iIQoYfFrS3tdwz75BGj2Sz89rQ7
	 aJCQnKI3/HEp4U2qhJjt9jAXcUtHhs+4PXPDHr/rVT9NdN9wcOrFPbObyg+bNK4nTc7AK
	 AHR4x46QnG2nIQFhZuZ7FyZtDzYALSFHeHqA77W96qkRopA2lFoR5YRTsBND7FWTnZPlx
	 V6CL81fqlqtTq1FCLVshZXFICF5KaDy8D07bK9VMxBR9cNIO75iRcxZDKDqKdW+Ti5XIO
	 hL0hf4+wNvZVciDxIctRyQ9Cl0RQIgBeAa8pSAzljAwRLU7+Q+EjKkRzrPN1BFgtnlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SUj6Hq/E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80113606A31A;
	Wed, 28 Oct 2026 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SUj6Hq/E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62C51F01825;
	Wed, 28 Oct 2026 00:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146764;
	bh=Of+Ihfq2JolsP7lQDuT/aMXMnMjzwRQu8EA+8gWaGVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SUj6Hq/E/BbsMuEPgwvTu+j59aaKTVRomAQqlezP6T5LfKJTaXDSIHye46Kac/A3j
	 zhAIed35qXIE1rALmYpMIjVWkPi3TV/Qu5E1tJdkR8j36fIw7yeXUl+PosckFVvipq
	 I3SmzaPG4nSarXEnDWZvJDI5Mzy7ZXolD3alEDUQ/KwZ8fnVjjeD9d9b0wbv8kLZWw
	 U7ZBFjbBT4SbtHAa+2GKllC8fgxCjii9c/xVnELEzTky1JActGEE7AqeblKcDPYcs6
	 Ri+2bWQqoQ1CTFN9sJzMx/xy64IJMKIyXleyk7nkibh4iFg1+o/+/Y0Z945UNCpLYP
	 BE1r0CbrGGQ7Q==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	corbet@lwn.net,
	damon@lists.linux.dev,
	jm5905938@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2 2/2] Docs/admin-guide/mm/damon/reclaim: rewrite complex parts
Date: Tue, 27 Oct 2026 17:19:15 -0700
Message-ID: <20261028001916.157488-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027212345.2586628-2-manuelebnerli@mailbox.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Manuel,


On Tue, 27 Oct 2026 22:23:46 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Rewrite complex sentences.

Any special reason to keep this as a separated one?  I think it is ok to merge
this into the first patch.

> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Suggested-by: Aveline Noir <jm5905938@gmail.com>
> ---
> Two more minor changes
> @ 31
> /s/attempts to pages out those/attempts to page out those/
> @ 126
> + 'is' to fix grammar
> 
>  .../admin-guide/mm/damon/reclaim.rst          | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> index 0bab2299ea..033686f410 100644
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> @@ -30,12 +30,13 @@ guests could mitigate this problem.
>  How It Works?
>  =============
>  
> -DAMON_RECLAIM finds memory regions that weren't accessed for specific time
> -duration and page out.  To avoid it consuming too much CPU for the paging out
> -operation, a speed limit can be configured.  Under the speed limit, it pages
> -out memory regions that weren't accessed longer time first.  System
> -administrators can also configure under what situation this scheme should
> -automatically be activated and deactivated with three memory pressure watermarks.
> +DAMON_RECLAIM identifies memory regions that have not been accessed for a
> +specified period and attempts to page out those.  To avoid it consuming
> +too much CPU for the paging out operation, a speed limit can be configured.
> +Within the configured speed limit, it prioritizes regions that have been
> +idle longer for reclamation.  System administrators can also configure under
> +what situation this scheme should automatically be activated and deactivated
> +with three memory pressure watermarks.
>  
>  Interface: Module Parameters
>  ============================
> @@ -125,8 +126,8 @@ quota_reset_interval_ms
>  
>  The time/size quota charge reset interval in milliseconds.
>  
> -The charge reset interval for the quota of time (quota_ms) and size
> -(quota_sz).  That is, DAMON_RECLAIM does not try reclamation for more than
> +The charge reset interval for the quota of time is quota_ms and for the quota of
> +size is quota_sz.  That is, DAMON_RECLAIM does not try reclamation for more than
>  quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
>  milliseconds.

I think the original sentence was not that confusing.  Also, this changes the
nuance of the sentence?  What the sentence is saying is
"quota_reset_interval_ms is the charge reset interval for ...".  If this was
really confusing, maybe we can add "quota_reset_interval_ms is " part.

But, I start feeling we might trying too much polishing...?

>  
> @@ -137,7 +138,7 @@ quota_mem_pressure_us
>  
>  Desired level of memory pressure-stall time in microseconds.
>  
> -While keeping the caps that are set by other quotas, DAMON_RECLAIM automatically
> +While respecting the limits imposed by other quotas, DAMON_RECLAIM automatically
>  increases and decreases the effective level of the quota aiming this level of
>  memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
>  per quota reset interval (``quota_reset_interval_ms``) is collected and

I'm not sure if the original sentence was really difficult to understand.

I'd prefer dropping this change.


Thanks,
SJ

[...]
