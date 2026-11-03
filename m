Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718336;
	b=o3lGi7K0Ckz1D47YwOdXmkken00iz3ZQVE/84G1SN6QTzwUT0hjkEi7HE8+6QgE5SOsv
	 Ryr6v5hfkbY5OpirPbRCbckqo4Lo3LbpL3tkePYHGIPR58xD963l0MFkhLPfneDbv8gcW
	 kxw8mJvZw+ssfsw59PTrVvQCvACsmGS/g6hTTsfDNUy6V4iTnMFrV5JW4J9IoeMHPmynS
	 UhYyVYpriHWsuv5ObnL0iqzSBMyGEpd35R+H4Bjr188OG9ryzs10LRdgrYP/9s6LG344z
	 FEU25ju466UJyb5QHmJVC0x3M3IR7t82lrAssocxfpO+rIvsddXpJfh4/V+akdouwnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718336;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IPfcmrcYcWX5lHrSru9Jn6n30jillltoM7EEkw0R5FY=;
	b=KPhLbc6GNS2tYaLgfO/30NRE83AeWL3nTwW/5+0OcN9uncPmspt83z818a5EihctZ/C2
	 Og57DI7m6GUZAaUk3imIoLuZD6+Su/CXsWDH/fDRvajTW0kwbF3QSYHTeP87NL7KCM8a6
	 i/VWJQBefzC4sI9AoNi2v+Wh6MXqWaetcx1gcUkkk0TUnW9eN3ASfU102BwHhV1mUddQV
	 o1Ks0RigGZzJ+SyRnXnVqCVE1XR/U6iW8NW8+wcjK3alrkNmQXuFv4t8yRVfHdsQaPtjz
	 50/l+rpc+5ha15O2pWXSsn+BT4BhPjC9Sgc6pV/tvHsltUJS+6vgRMPf04Q0dkOclRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7EFxg3V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97183606C822;
	Tue,  3 Nov 2026 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i7EFxg3V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE301F000C1;
	Tue,  3 Nov 2026 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718336;
	bh=IPfcmrcYcWX5lHrSru9Jn6n30jillltoM7EEkw0R5FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i7EFxg3V7LiVQlqu8g676hJBANeRvsSGORz8SVztNkzVPMstOH8WIxPuhsKQjBDCt
	 Jmw3i2bsC8Nr9dlBur0QU12T0/idc3zOpSS4jruSjYWDlqHDfphVroG5rpf0HOkwY7
	 d3tPTNrgnLhntZI+F9MEB3J34SQ0hvuSOqL2dIVjnS3bElYdlmrJ4GUurhiPgO7312
	 0hdKRAcooUqT9/OF/D3wsE1mAW7cMg4am0VtyypFQDLBQDzoSCjuQZxP6EobwPLLlt
	 JpVGZ1H8EptRPXzvCCNasSFlCEErCWvk/Cqjj0KmyQhweuHYzUpdyX3q3fjT2zYGb/
	 OvneJ4V790e/Q==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Aveline Noir <jm5905938@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Docs/admin-guide/mm/damon/reclaim: improve language
Date: Tue,  3 Nov 2026 07:05:28 -0800
Message-ID: <20261103150528.88546-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103120043.100887-2-manuelebnerli@mailbox.org>
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

On Tue,  3 Nov 2026 13:00:42 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Fix upper case.  Fix tenses.  Replace 'set as' with 'set to'.  Add space after

Please wrap lines for 75 chars per line, from the next time.  Otherwise,
checkpatch.pl will warn like below:

    WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)

> sentence to make it double space.  Rewrite and refine complex sentences.
> 
> CC: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
> That's the final version.

Thank you for revisioning.

[...]
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> @@ -4,7 +4,7 @@
>  DAMON-based Reclamation
>  =======================
>  
> -DAMON-based Reclamation (DAMON_RECLAIM) is a static kernel module that aimed to
> +DAMON-based reclamation (DAMON_RECLAIM) is a static kernel module that aimes to

Sashiko suggested [1] s/aimes/aims/ ?

[...]
> @@ -88,7 +89,7 @@ identifies the region as cold, and reclaims it.
>  autotune_monitoring_intervals
>  -----------------------------
>  
> -If this parameter is set as ``Y``, DAMON_RECLAIM automatically tunes DAMON's
> +If this parameter is set to ``Y``, DAMON_RECLAIM automatically tunes DAMON's
>  sampling and aggregation intervals.  The auto-tuning aims to capture meaningful
>  amount of access events in each DAMON-snapshot, while keeping the sampling
>  interval 5 milliseconds in minimum, and 10 seconds in maximum.  Setting this as

Sashiko also suggested [1] to update above 'Setting this as' to 'Setting this
to'.

Other than above two,

Reviewed-by: SJ Park <sj@kernel.org>

Assuming you don't mind accepting above two Sashiko suggestions, I applied this
patch with the suggested changes to damon/next [1] tree.  I will repost it soon
(~1 week) as an mm.git merge request.  So, no action from your side is needed
for now.

[1] https://lore.kernel.org
[2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
