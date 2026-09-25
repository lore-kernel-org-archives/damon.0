Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947E3D9DB1;
	Fri, 25 Sep 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331232; cv=none; b=SUwYiGUZm5d0mvZlpL5v9rbIzXP7rQKTNpMu7Ie51PKFbD7YQd2vusJ2SOBKCdwZnlb+dw+W2Bce0VtCDIxTPZl1Apwja9ycUjpna0630YaVwOqs8VgVACnMyvXzgt6zIWPIeViKPzudzUa0Fj7vds85zCXguHeBUSZzdyFz+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331232; c=relaxed/simple;
	bh=YDJueMA5ud8hcpAbk9ruKM/yPP9qKHMOVJj4yjwJaXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msQQhFqtxUdfKHxUE+aBUanu7LrMisZbZkJaCEjhBUJ5b97GyN6ZhwjY6G2FZt4yPEfZnvnfQSznFSYIS+ltn7DAo1ruDsepn7AJM1YI4SVBJ1et/v86Qr9DtRhHBZVwMd/d6cVV9Y0Wwdp0M2WtdqtkQyGmJOusJ5YKohJf/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvvqWOPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvvqWOPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DF11F000FF;
	Fri, 25 Sep 2026 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331231;
	bh=UvTmyd62NBwPnh1Rpluu6TR3mWFhWCcbU/2COoqGdLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NvvqWOPqHwDB7b4EieW2LrcnPCJawtrbIfkw04FY4bPgyu9mU08uV6/OK3SBmW5QW
	 27XiiSIqsyjoqK1GukPc7SuaJmpdXa4wcxGR5wyqZLL2MfMryc6MHAjpvP9BJToIiE
	 qlPmgpdLWTALGwfqvs4oxi1IgUpmQIJ59NIHkrCBKx3qiBj65y8BFVlMu71aUd74mG
	 ovB5F76svNHCn/TdhP5H2639BPuc30kJWQolmjCf5QuVvs3rR9FpZXo/hBoZeFIRXD
	 N8vi0L3EUtkpmBZrmGkiew5vOooElz4cP5BJxezPJMy4UpxnZJqhSEa9fYQ7EmUmNw
	 rLjyZ+gdlhHKw==
From: SJ Park <sj@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	mst@redhat.com,
	david@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	ryncsn@gmail.com,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	baohua@kernel.org,
	xueyuan.chen21@gmail.com
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Fri, 25 Sep 2026 03:13:31 -0700
Message-ID: <20260925101332.49502-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925054408.10431-1-lance.yang@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lance,

On Fri, 25 Sep 2026 13:44:08 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> Hi all,
> 
> I was reading DeepSeek's new DSec paper[1] and found a nice use of DAMON
> and virtio-balloon:
> 
> With this kind of workload, an agent may read a file once and never touch
> it again, while those pages remain in the guest page cache. Without memory
> pressure in the guest, they can stay cached even though the host would
> like that memory back ...
> 
> The trick is DAMON + virtio-balloon free-page reporting :) DAMON reclaims
> cold file pages from the guest page cache; buddy gets a chance to coalesce
> them into reportable blocks, and virtio-balloon passes those blocks to
> Firecracker. Firecracker can then drop the host backing with MADV_DONTNEED.
> 
> And it worked: time-integrated host memory use fell by 21.2%, while peak
> usage stayed about the same, with no significant CPU overhead. Pretty cool
> to see these pieces show up in another real, large-scale system :)

Thank you for sharing this, Lance!

> 
> Kernel work still changes the world. Cheers to that!

Indeed, the community is making the work a great place.

> 
> Anyhow, I still don't know DAMON and virtio-balloon as well as I should
> (mostly I just know the people who built them) :P

Please feel free to ask any question to DAMON community and me, whenever you
get :)

> 
> [1] https://arxiv.org/html/2609.22978

I only briefly read the paper.  But it looks like DeepSeek's DAMON usage is
similar to AWS' DAMON usage [1] for their serverless service.

While I was in AWS, I proposed [2] a more advanced version called
Access/Contiguity-aware Memory Autoscaling (ACMA).  After the RFC idea v2 [2],
no progress is made so far, though.  I shortly covered it in LSFMMBPF'25 [3],
but all I mentioned was that the project is suspended.  Recently a useer has
personally reached out to me asking the status of ACMA.  It is too early stage
of the discussion to say or promise something in my humble perspective, though.

[1] https://cdn.amazon.science/ee/a4/41ff11374f2f865e5e24de11bd17/resource-management-in-aurora-serverless.pdf
[2] https://lore.kernel.org/all/20240512193657.79298-1-sj@kernel.org/
[3] https://lore.kernel.org/all/20250121183103.42877-1-sj@kernel.org/


Thanks,
SJ

[...]
