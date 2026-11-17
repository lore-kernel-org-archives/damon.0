Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926039;
	b=qpjA6n4Gm+S5jz0bBkVLpBnXASbUfsv2n8MzD7bxJK4m53eGoDGFDriR/7xIJMwLI7ES
	 YtkGUqXrywLWtmK8U6RjeKAQFTiS5+fjWxpc/cZjRmz6kVEFqqcqj0c8RRUZwJMIiDzht
	 38mqEZP+ZOrsxwtsX6ScBkpE6JiWNN1kxQEmLpV2orTNDTp+qPoZExrisLaGtFXry2hvl
	 YVwSI9zOy+POYoeAtQF6Vjo7db8ejrSj2kimhvWHN9d/DxkPPYsDJ2DxtEZWQ0EBcjfJm
	 1rwpm3Lf1t7QUqoTpT9XHEDhJYFEF8RwN2zWMo7qt5VLgieqIfrBCtf2YpEwM2mbHZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926039;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8lJn5i3rB8hKxekAA9fjmUZ4HWkDFl1+fq3jMpfeiZY=;
	b=4IhtKilX56Ww9BsUEDutBcNw0unJYfvktGUEcnQysrpzd+oyYOZDWs3zjGxJ5zBdUZyW
	 AofebS0UfNOgjUa/7MibashneYDR16MDYShFt1Tg5p3PaAgr3Zn3sdhbjd0v1wL0By0KQ
	 ioatW92YUzXFKJ/SH6mMe8ABKEWyOmq+NZA1rNxNx0nIVbsDneK+BCwNaaE5EzaUlXywd
	 i9y7zFU2WCkfra7VclQGwUAJIvNlk/7+jN3cwsRA19MGPvaKL908LAhLh94IFtRQDg9uJ
	 wcFPgP2ejOe1MqM4MbB0f6ipITx4f7xeTD3OM0Fh+QCr7LAJs0XDu7A0b6iIp2j4nwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VqTh/yMX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C755606A32F;
	Tue, 17 Nov 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqTh/yMX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8D21F000C4;
	Tue, 17 Nov 2026 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926039;
	bh=8lJn5i3rB8hKxekAA9fjmUZ4HWkDFl1+fq3jMpfeiZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VqTh/yMXXl6eU95sOIdz8nSlg3vVLthgUnKTxjjfYVKLjNA8AMU6YVK+xi5lI8yVC
	 os1kppKGNFo89igovqaicw3qmvxvOT5Ar0NKlYin4F8+GZHPgquSRzqzDoq24Iy95l
	 QX22x6FkoYYaEDI8Ki5USCIgZrvGWuISGlaitQyHSj8yXIWSsXODyUq+2Z7QwTnIei
	 M1SOdg8gUsHTanPlFcVuvoEo4JcGv3vSo2e9IO0ThicDU8a5Omf54yz7l65F3FV9fI
	 KwM0gPzHgrNwDUBzkSG0MPvrIbQJASTo0VcmdvuwUeaPZQDI+/IE7+eBwpmdec7fyC
	 UeNTm5MKweqpw==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/paddr: skip hugetlb folios as a whole in pageout
Date: Tue, 17 Nov 2026 06:33:51 -0800
Message-ID: <20261117143352.121497-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117-fix-damon-hugetlb-pageout-20261117-v1-1-054ef8760a92@gmail.com>
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

Hello Aveline,

On Tue, 17 Nov 2026 17:06:54 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> damon_pa_pageout() uses damon_get_folio(), which rejects hugetlb folios
> because they are not on the LRU.  The loop then advances by PAGE_SIZE and
> looks up every base page of a hugetlb folio that cannot be reclaimed.
> 
> Use damon_get_monitor_folio() and skip a hugetlb folio as a whole by
> advancing to its end.  Do this before the filters, the accounting and the
> last_applied check, so that adjacent regions within the same hugetlb
> folio are not walked by base page either.  Test the LRU flag first to keep
> the hugetlb check off the path of ordinary LRU folios.
> 
> In a pageout microbenchmark in an x86-64 KVM guest, traversal time
> dropped by about 99.7% for regions covering whole 2 MiB hugetlb folios.
> As a side note, there is a small overhead of about 1 ns per region when
> each region is a single 4 KiB page.

Thank you for this patch.

> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> ---
> Tested in x86-64 KVM guests.  KUnit passes.  The damos_quota.py selftest
> can also fail without this patch; I will send a separate fix for it.
> ---
>  mm/damon/paddr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5b773012a876..aca48bf752c8 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -268,7 +268,9 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
>  
>  	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
>  	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
> -		folio = damon_get_folio(PHYS_PFN(addr));
> +		folio = damon_get_monitor_folio(PHYS_PFN(addr));
> +		if (folio && !folio_test_lru(folio) && folio_test_hugetlb(folio))

Why do we need both !folio_test_lru() and folio_test_hugetlb() here?  Could
hugetlb folio in lru list exist?  Could folios not in lru list be reclaimed?

Would only !folio_test_lru() suffice?  If so, the patch subject and description
may also better to be updated.

> +			goto put_folio;
>  		if (damon_pa_invalid_damos_folio(folio, s)) {
>  			addr += PAGE_SIZE;
>  			continue;
> 
> ---
> base-commit: 67f3b04b277373438f17300e056306adbd9edf7b
> change-id: 20261117-fix-damon-hugetlb-pageout-20261117-a4e03d9d5a5b
> 
> Best regards,
> --  
> Aveline Noir <jm5905938@gmail.com>
> 
> 


Thanks,
SJ
