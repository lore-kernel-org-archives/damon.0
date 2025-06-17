Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14420D4FF;
	Tue, 17 Jun 2025 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199407; cv=none; b=mAfE2H8dO8EZgkCZCZdGE83lnmghxB8252Yid4VIo4c5KeKP7DyAkPqx6vFhET/Ysc1O23JBb4I9iI+U7fTpDAitJvly3fQKRkvP+IfKxhdLG1Qt1vALJ8gXKPNm5XJ817eTrRN8fWQDkxMJ4fzEbwQRollXI9PztLt6/kOihgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199407; c=relaxed/simple;
	bh=SGGyiCoTGoTxw00KV1kNaqflYtCwj4p1ZTrArbPnXIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+xqcn834W0501ZV4J0Qk70Eghx0F/jybGsEhs3roKdtuwaIT51x9KpmDs14r/pe8r13+gD2FuPSJZYFwTya7FLMNLmXDN+1V2HNOXRUPh7hBjs7CQcSr90pYbGkBwWv4SLnpJtEmxcG3HsHPfvLEU+BSqeMkX5IEkDwFpB9jg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF8NQaqd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF8NQaqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDD7C4CEE3;
	Tue, 17 Jun 2025 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750199407;
	bh=SGGyiCoTGoTxw00KV1kNaqflYtCwj4p1ZTrArbPnXIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HF8NQaqdgVNbeHkHl3F1yA+9mKX3t6FafblUPQ6vixdZRiOBXLamWK1sgcmtAQWdP
	 wcdIlJekyyZibdEs78WcHv4n/5GYwJrI54JPxp67dy48ssMlHjdpOFVcprQUsXBCY8
	 AubqlKue0z0/rGlkLM0zsXdZCB68odDs1AaWTNtod2ppAW+UbHR3Llhz7oHQIocz2D
	 0cRTGWiXnm+mwRJi1nJ5eqIG+lT047LaTVf+ZlOrD4032jf+KCfxgIuWdNz99tck4r
	 2SYBG4JBnGoNY2F93E8Ax9MLSW3cf+mpa0+NZFMP0rWrRgZZZn8V6a9GHnV6tj9MKy
	 IcgF9wKcy3rOQ==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in include/linux/mempolicy.h
Date: Tue, 17 Jun 2025 15:30:05 -0700
Message-Id: <20250617223005.2526-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS7yQPoXxAecSi6B74a1Bgm1H06i+MqNDgdsZODEZSYFuw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Jun 2025 14:54:39 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

[...]
> Given this discussion, as well as Joshua's comments earlier [1], it
> sounds like while people aren't exactly opposed to using mempolicy for
> this, the building consensus is that it would be best not to. I will
> move the interleave logic to DAMON for the next revision. However, I
> still think it makes sense to use the global weights (probably via
> get_il_weight) for now to avoid allocating pages a certain way and
> then migrating them soon after.

Makes sense to me :)

> 
> I'll try to send the next version of the patch set by the end of the week.

Looking forwrd to it!


Thanks,
SJ

[...]
