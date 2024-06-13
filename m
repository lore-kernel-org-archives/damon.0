Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C06144D36;
	Thu, 13 Jun 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287417; cv=none; b=RVQ4TUy1/KwBug8ICV+5Z9hOQXrpvQH8B5XH3IrBs6AQl4tPhXEo4Q4axDP14vcZXKuoU9FnqmNyWC5HXVUj/pC291dsqg75tK+zuy4io9wVcXHAxbfwrj/idETJsJeA6YFStPNHPSDUKib6ii98pbasouDMKrmLZGzphnLPOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287417; c=relaxed/simple;
	bh=ZEB6dzh79zObt/arRlHAONB0K6ulFY49wVE8g2mqSDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=DATOrv48xT3vo4qkgpH9KCVMeaD/tTmNYyua+sV+bOBMbm2WuKpWL9sarExOjVTvhhSbTnSm0rHS5vPqbnGGKfho43n6XqAr7d0ad/VNByf/g9cpJPECmMNZLu6V7K4vV0sQMmaPnJHVublwrC3PnBqWGMXLMS/ZR9HdEn/alvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVCE3pN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVCE3pN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA84DC2BBFC;
	Thu, 13 Jun 2024 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718287417;
	bh=ZEB6dzh79zObt/arRlHAONB0K6ulFY49wVE8g2mqSDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=rVCE3pN+CZIlRQ3pVHTyddDPv54KujZjVQXZOR5yrzQreclhZO6QdwQXA61WK94KR
	 FI6RAMT1WM3quDNPt9wDIXlvn8WXx+0uUV8a6tvuFpzSyGt3rQpnI6N83WZ9stVaVA
	 svtBvuCzW4IwnBhO49YJ7RibVJaMLkOqXHnXFjjSHrAjW/fSyPHrcrEZJdgvZZ2GIC
	 9Ve3IgV1IErMm4BU++/30tPoP/EDPU3MignAdvcsPOje3FuOT1ON68IrjDfL+kvpyo
	 EauqeymaSlKV7NrdCyfu01gQY7EQVoD5xoKT63ld5vg0PX6B4vbKKMPUdX95R41hLg
	 zfgaMdGSBThsg==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com
Subject: Re: [PATCH v5 7/8] Docs/admin-guide/mm/damon/usage: add missing actions
Date: Thu, 13 Jun 2024 07:03:19 -0700
Message-Id: <20240613140319.27075-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240613132056.608-8-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Hi Honggyu,

On Thu, 13 Jun 2024 22:20:54 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> "lru_prio" and "lru_deprio" are missing in the damos action list so they
> have to be added properly at damon usage document.
> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> index e58ceb89ea2a..7bff54963975 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -757,7 +757,9 @@ list on :ref:`design doc <damon_design_damos_action>`.
>   - 2: ``pageout``
>   - 3: ``hugepage``
>   - 4: ``nohugepage``
> - - 5: ``stat``
> + - 5: ``lru_prio``
> + - 6: ``lru_deprio``
> + - 7: ``stat``

This section is for DAMON debugfs interface, which is deprecated.  After the
deprecation, we stopped supporting new DAMOS actions.  This section is not
documenting lru_[de]prio for the reason.  I think this patch is not needed.

Please let me know if I'm missing something, though.


Thanks,
SJ

[...]
