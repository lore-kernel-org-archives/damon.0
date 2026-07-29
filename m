Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC342FCC5
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328646; cv=none; b=SrnfUcUGa1uXdus0c3xOE9y41FgPRBK3xcHQlUtn1cQmWWjMWa4T/mM8Jf4MFWfWuGImW+B3XZnzR4gYhcgUIRi5QsJhsInYxfjCnRDWnZ59VPhfupWv4DrDTBd6AygoAEFwf3VnYB9NZlV9eDhxO+Az+7Tuuimwxk3ZzHZ8O/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328646; c=relaxed/simple;
	bh=RqBIaQtofOMglq8E0sS3S2TKa8v1b6XvPGQKltQWdqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF04x5YjAZvUot66o/Q5TmiN6O7UxIeUOvAEIx3yCDPBD5GLsMSrgXlETlYNSeOt7LQxoxILRznGN0t/Na28zcck3odPCIHwyqTzJyRqI8lUinvyxoVxYABd7wjbSo54WzhIYvauqNlmGkbETIfGdC3sz3gyrtRQyk8rCf2eYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HsBO/9wN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vhLdNBgT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nBonCs6a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BT3fFBrc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HsBO/9wN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vhLdNBgT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nBonCs6a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BT3fFBrc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AE6C7CAFF;
	Wed, 29 Jul 2026 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785328628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCPopA3duELZWRFQ7PC+zcU7UIlf1ZyVyMzN0xmYHFs=;
	b=HsBO/9wNGNK0BBi/KZnybjT4wfzH1RbauNRa3BkCq1Gz1ZFYfyulio9BMMz/Qhlayjht8v
	gD7JzPlP/j/lbzamJYZIEmtCD/24X5mlh9Cm7ueizVVj2a3/38UgR1iUgozDxsYGd00nVJ
	81gftDjjAsCoQcZd/g/wQgIFNVzYSPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785328628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCPopA3duELZWRFQ7PC+zcU7UIlf1ZyVyMzN0xmYHFs=;
	b=vhLdNBgT3LES3Nfy+reOhuZbF+sRDMgTm8/+rp44QydsQ0PgJmekRb7kN8gf1KeP/gQfF2
	vhVMad65mEjeOWBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nBonCs6a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BT3fFBrc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785328624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCPopA3duELZWRFQ7PC+zcU7UIlf1ZyVyMzN0xmYHFs=;
	b=nBonCs6auu91fwhTCPSwwqM/BnHZLlIGXt/TmMHVYSy429b64ZCJOljFWGBAHwpGwsp+VY
	26DPb6Xoz2zlvJd7icT3XVFcHRopeHCqPAv9U3TcLO99ha0MheRXkinzHltD+E4YU5GueL
	hsbqCAyQMiJN0MmV5BgL9eX8TbAHxvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785328624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCPopA3duELZWRFQ7PC+zcU7UIlf1ZyVyMzN0xmYHFs=;
	b=BT3fFBrcAWB//UVTCQRGI3kpRDayFQs1zsoB1XrNCj60pSuBHTbHXO+sVcJVpP7eK4LEaV
	7UMRX0P/16CpuzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11699779A1;
	Wed, 29 Jul 2026 12:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +/ToAOzzaWpxRgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 29 Jul 2026 12:37:00 +0000
Date: Wed, 29 Jul 2026 13:36:58 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, SJ Park <sj@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, ziy@nvidia.com, 
	agordeev@linux.ibm.com, ryan.roberts@arm.com, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 09/11] misc/sgi-gru: use ptep_get() for page-table
 reads
Message-ID: <amnxCmFU40QQaxTx@pedro-suse.lan>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-10-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727164715.2866609-10-usama.anjum@arm.com>
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0AE6C7CAFF
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,hpe.com,arndb.de,linuxfoundation.org,hansenpartnership.com,gmx.de,suse.com,kernel.org,linux.dev,suse.de,linux-foundation.org,infradead.org,soleen.com,tencent.com,goodmis.org,iogearbox.net,redhat.com,suse.cz,ziepe.ca,huawei.com,gentwo.org,cmpxchg.org,nvidia.com,linux.ibm.com,arm.com,vger.kernel.org,lists.freedesktop.org,lists.xenproject.org,kvack.org,googlegroups.com,lists.linux.dev];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL68tbpjnwz7cuja85sfonjfqu)];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_GT_50(0.00)[66];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,pedro-suse.lan:mid,suse.de:dkim,arm.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Mon, Jul 27, 2026 at 05:47:00PM +0100, Muhammad Usama Anjum wrote:
> A leaf PMD is being read through ptep_get() by treating the PMD address
> as PTE-sized table storage. ptep_get() now accepts hw_pte_t *, so update
> the cast accordingly.
> 
> pte_offset_kernel() also returns hw_pte_t *. Get pte_t value by calling
> ptep_get().
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
>  drivers/misc/sgi-gru/grufault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index 3557d78ee47a2..ff89d34ad2aa4 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -228,10 +228,10 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
>  		goto err;
>  #ifdef CONFIG_X86_64
>  	if (unlikely(pmd_leaf(*pmdp)))
> -		pte = ptep_get((pte_t *)pmdp);
> +		pte = ptep_get((hw_pte_t *)pmdp);
>  	else
>  #endif
> -		pte = *pte_offset_kernel(pmdp, vaddr);
> +		pte = ptep_get(pte_offset_kernel(pmdp, vaddr));
>  
>  	if (unlikely(!pte_present(pte) ||
>  		     (write && (!pte_write(pte) || !pte_dirty(pte)))))

This code is super, super broken. Can we remove this ASAP? For starters,
we're using is_vm_hugetlb_page() to detect page shift, the code does not
grab refs on the pages, uses pte_offset_kernel() on user page tables,
does not handle PUD-level hugepages, does not handle PMD-level hugepages on !x86_64,
does not hold page table locks nor check for pte table retraction, etc

I don't think I need to go on.

-- 
Pedro
