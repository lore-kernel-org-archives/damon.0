Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2993C09FC
	for <damon@lists.linux.dev>; Wed, 27 May 2026 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881017; cv=none; b=HdIiCkepKCj6CQQ3vWrmtJ1tOOXx6FeGkFDMTF1fRxV7wkluVMXXoOqjjbv/hio3SjWo0hAdjC/hbWic4nsaDuJU44ZwKp47HcHN0+TD/QYKuGth73vqMITsLdEi7OVuDTPk4xZgFgBlfkXvzUVYXfTiq9vaBdhnCMpIwXLx6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881017; c=relaxed/simple;
	bh=2q0N0ZlqQEDw2c9h6pZIAZj6vqQp0AfH6x5YuFas+Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSW77zAzLtx9wrdo10onfeyjGYwBvOJgLh/VtNHkkeawF2Qw3J481Zh3FcWENZ/JG8E3Uw3W20IGLLnsMEqSShIkXSXRGrG21Wr908dlF9rgEUY7b5vE2A24ogsv8Lpiz3UcFmEeYsrcwfcfq8LCZxjM/R7vDBC/3eMP30hEZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cQkSSB30; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EkGTAOuz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cQkSSB30; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EkGTAOuz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cQkSSB30";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EkGTAOuz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cQkSSB30";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EkGTAOuz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2672366E9B;
	Wed, 27 May 2026 11:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779881014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQymIob/bHvpmY35om5H+zfV6sgTV20OvOeUiMVaTTk=;
	b=cQkSSB30Nn9V8SWFWhuaBkFN8vkGwfyFfnbmm84+ElI3TpFKPan28dYs7HrdQS7kU2zW9o
	XJomGoFsh6jLDIQwypT1E3uIZbfEXWMR735yMUJACGYOB2HEIDJJ48HXtgmwrgCQeQtoOD
	VZiWcXyE9aGUyvRWpjmhi2iO24udAbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779881014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQymIob/bHvpmY35om5H+zfV6sgTV20OvOeUiMVaTTk=;
	b=EkGTAOuzgsIN+8uGREd/BK/l/mWwjnKQGEjhMTWE3VG1spUBZIxGhruFkqvAovkW46ERdd
	E1AtWfcQlt6z9vDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779881014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQymIob/bHvpmY35om5H+zfV6sgTV20OvOeUiMVaTTk=;
	b=cQkSSB30Nn9V8SWFWhuaBkFN8vkGwfyFfnbmm84+ElI3TpFKPan28dYs7HrdQS7kU2zW9o
	XJomGoFsh6jLDIQwypT1E3uIZbfEXWMR735yMUJACGYOB2HEIDJJ48HXtgmwrgCQeQtoOD
	VZiWcXyE9aGUyvRWpjmhi2iO24udAbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779881014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQymIob/bHvpmY35om5H+zfV6sgTV20OvOeUiMVaTTk=;
	b=EkGTAOuzgsIN+8uGREd/BK/l/mWwjnKQGEjhMTWE3VG1spUBZIxGhruFkqvAovkW46ERdd
	E1AtWfcQlt6z9vDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E8755A7E0;
	Wed, 27 May 2026 11:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xr8IHzLUFmpCJQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 27 May 2026 11:23:30 +0000
Date: Wed, 27 May 2026 12:23:28 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: tao <tao.wangtao@honor.com>
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, willy@infradead.org, sj@kernel.org, 
	kees@kernel.org, luizcap@redhat.com, zhangjiao2@cmss.chinamobile.com, 
	kas@kernel.org, ljs@kernel.org, hpa@zytor.com, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	jack@suse.cz, riel@surriel.com, harry@kernel.org, jannh@google.com, 
	jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, nao.horiguchi@gmail.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	damon@lists.linux.dev, shakeel.butt@linux.dev, ryncsn@gmail.com, 21cnbao@gmail.com, 
	jparsana@google.com, dvander@google.com, zhangji1@honor.com, wangzicheng@honor.com
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <ahbSwczOpsBKby7o@pedro-suse>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527110147.17815-1-tao.wangtao@honor.com>
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,redhat.com,alien8.de,linux.intel.com,linux-foundation.org,infradead.org,cmss.chinamobile.com,zytor.com,google.com,suse.com,suse.cz,surriel.com,ziepe.ca,nvidia.com,linux.alibaba.com,linux.dev,zte.com.cn,gmail.com,intel.com,sk.com,gourry.net,lists.infradead.org,vger.kernel.org,kvack.org,lists.linux.dev,honor.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	R_RATELIMIT(0.00)[to_ip_from(RL3mhzhn45zpqpmgqn4z7synfm)]

On Wed, May 27, 2026 at 07:01:32PM +0800, tao wrote:
> TL;DR
> -----
> 
> This series introduces ANON_VMA_LAZY, which defers anon_vma creation
> until it is actually required.
> 
> - anon_vma memory reduced by ~92-97%, anon_vma_chain reduced by ~50-57%  
> - rmap operations on ANON_VMA_LAZY VMAs do not require anon_vma locking
> 
> Background
> ----------
> 
> Currently anon_vma structures are created eagerly when anonymous VMAs
> are initialized. However, many VMAs never participate in fork or rmap

This is not true, they are created on fault + a few other places.

> operations that require anon_vma chains, so the allocated anon_vma and
> anon_vma_chain objects are often unnecessary.
> 
> Design overview
> ---------------
> 
> ANON_VMA_LAZY defers anon_vma allocation until it is actually needed
> (for example during fork). VMAs that never participate in sharing can
> avoid creating anon_vma structures entirely.
> 
> Before an anon_vma exists, rmap operations rely directly on VMA
> information, so no anon_vma locking is required. An anon_vma is created
> and linked only when sharing semantics are required.
> 
> This series introduces anon_rmap helpers to make rmap less dependent on
> direct anon_vma access. It also introduces anon_vma_tree_t as a container
> to support both the lazy and the existing anon_vma layouts.
> 
> Once a VMA becomes associated with an anon_vma, the normal behavior
> remains unchanged.
> 
> Memory impact
> -------------
> 
> Preliminary measurements show significant reductions in anon_vma-related
> slab allocations.
> 
> After boot:
> 
> Object            | Before (active KB) | After (active KB) | Change
> vm_area_struct    | 117035             | 118176            | +1.0%
> anon_vma_chain    | 18865.8            | 8112.06           | -57.0%
> anon_vma          | 20426.4            | 613.75            | -97.0%
> 
> After launching 24 apps:
> 
> Object            | Before (active KB) | After (active KB) | Change
> vm_area_struct    | 196873             | 197345            | +0.2%
> anon_vma_chain    | 31477.1            | 15576.8           | -50.5%
> anon_vma          | 33280              | 2648.12           | -92.0%
> 
> Simple fork microbenchmarks also show a slight improvement in fork
> performance, since child VMAs do not need to allocate anon_vma
> structures during fork.
> 
> Feedback and suggestions are welcome.

I'm afraid, per previous discussions[1], that no one is really willing to
maintain extra complexity for the current state of anon rmap and anon vmas.
Sorry :/

Also, please don't send series this large without previous discussion and
_at least_ an RFC tag.

[1] https://lore.kernel.org/all/aec533b2-37a7-4f44-a279-c4aa604206ac@lucifer.local/

-- 
Pedro
