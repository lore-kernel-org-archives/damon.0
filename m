Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ACA436342;
	Mon, 17 Aug 2026 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974131; cv=none; b=ZwPdCfGRReQ5gZzxTDkKqr8CMOvEjQ3QOjgzb71x9wwaNueEuiVj0YPJhgokavKEshUgp6MiXTbG5WACbh9BHiq3RU/viso1LObHvY5NdLH2xvVgkeiUz3IkgWLorfcq3XsQ91k7hFUKkshOPfd0i0EbKknrD5S2cP8GGaEKsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974131; c=relaxed/simple;
	bh=VmUolJpkPhJhAlyNerUL4btJ5oSMz22hfjB1pT7W1Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G570DBDMo8R9rFZV5sItz+F/PU5X8TzBKCs+iE6RArX83KfIHbdm/IHsCdOfkUavXwqbEbodSCcMViqSGG4nVxU1PDRF3oBbGaO3i4cdOWJ7S9gFQZ/hqG4/2tkwXSredk0mdjoTsErQzFnvsYq4bAcP1I64NH1HwhUk9w5JUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUgKhK7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUgKhK7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2777C1F00A3A;
	Mon, 17 Aug 2026 13:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786974129;
	bh=THX0Z/8utD7j+IXnwYTDcoLP5zSf7naxjyTV86BLgDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kUgKhK7AoUwKAqnbkbeYM5ehgQFaN+R6d+cdrlJ8KaoIb724DCtdhNNOBc66wwJEv
	 s5bP4WMHROjY9Im4Ure/mxamJRMC7nFf0tE5QJBZTNyH6pMogVxuNNuI1o8nTuj1Gx
	 UYGH+JsT6fsECYGb1mkTufCVdjmS5KIoXGg0c3c/dIKXKNtxzAbS13yDzmA2Hz9pYL
	 jCx2GZ577NJ0JSH2K/VNuzLCqvNhX3IsGZ7XDSYrnhwsP0MOT6+8OZyOx7D7hkO0sG
	 UZnoP8n3+xFN304mgxB2QgGsUjPSNNfcRUtS4BzQVBk6X82MqZQ0SnN5WlZCk8X3j9
	 ohfonFOSaP52A==
From: SJ Park <sj@kernel.org>
To: dayou5941@163.com
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	Li Youhong <liyouhong@kylinos.cn>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: factor out damon_putback_folio_list()
Date: Mon, 17 Aug 2026 06:42:00 -0700
Message-ID: <20260817134202.75525-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817063458.351063-1-dayou5941@163.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Li,

'get_maintainer.pl --nogit --nogit-fallback' suggests adding below recipients.
I added them.  Please consier using get_maintainer.pl from the next time.

- linux-mm@kvack.org
- linux-kernel@vger.kernel.org

On Mon, 17 Aug 2026 14:34:58 +0800 dayou5941@163.com wrote:

> From: Li Youhong <liyouhong@kylinos.cn>
> 
> The putback loop is duplicated in damon_migrate_folio_list() and on the
> invalid-nid path of damon_migrate_pages().  Factor it into a small helper
> for readability.  No functional change.

Thank you for this patch.

> 
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> 
> ---
> Note:
> As previously pointed out by the AI regarding whether removing the local
> variable struct folio *folio in the damon_migrate_folio_list()function
> would introduce build-time issues: no build failure will actually occur.
> This is because struct folio *folio is only used inside the while-loop.
> link: https://lore.kernel.org/all/20260724060707.CE1F81F000E9@smtp.kernel.org/

But, a build on my setup actually fails like below:

    $ make O=../linux.out mm/damon/
    [...]
      CC      mm/damon/ops-common.o
    mm/damon/ops-common.c: In function ‘damon_migrate_folio_list’:
    mm/damon/ops-common.c:357:17: error: ‘folio’ undeclared (first use in this function)
      357 |                 folio = lru_to_folio(folio_list);
          |                 ^~~~~

> 
> ---
>  mm/damon/ops-common.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 0bcad6b1e5b9..5c0c941b7f75 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -329,12 +329,24 @@ static unsigned int __damon_migrate_folio_list(
>  	return nr_succeeded;
>  }
>  
> +static void damon_putback_folio_list(struct list_head *folio_list)
> +{
> +	struct folio *folio;
> +
> +	while (!list_empty(folio_list)) {
> +		folio = lru_to_folio(folio_list);
> +		list_del(&folio->lru);
> +		node_stat_sub_folio(folio, NR_ISOLATED_ANON +
> +				folio_is_file_lru(folio));
> +		folio_putback_lru(folio);
> +	}
> +}
> +
>  static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
>  						struct pglist_data *pgdat,
>  						int target_nid)
>  {
>  	unsigned int nr_migrated = 0;
> -	struct folio *folio;

Above declaration removal is causing the build failure.  Let's keep the
declaration.


Thanks,
SJ

[...]
