Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401C25EFBF
	for <damon@lists.linux.dev>; Tue, 23 Sep 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643006; cv=none; b=TBjMJNip9yS5/hwwxtvjdWVQxyLUeaqcS+JdkQUdABztApJ2kKiKXKKrGBn8RxpAHc8E5/FhPO20g25a3FWqvYXamsNRonys5sRWa9ToF/Hgbsv8wckRzf0hFKyeEhzNb092E4yj8AzfbPTGiPqaPBIXxAW8erXjTzcw0fIipiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643006; c=relaxed/simple;
	bh=7xcrEyFC+WS6yolaKMt8zA4l8k1ql4prabs4jrFFfx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeQX9T/Iic6aJ+T+nZO2ipdY1IctuDfrTX4hTZy5qF5NlgTsXp1aeLBM5ol6dzdfozgNPcvOCGnx1LZrWvmMSTPoyUJSb/xQLRw/r3aRYM8v60tPTQRW8jfqvWvCo0jb2xrMavzpg5fq22Hzi5ieydkPW4LTdUt7GM5TzHZtE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Brz8GCh1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brz8GCh1"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso36697215e9.2
        for <damon@lists.linux.dev>; Tue, 23 Sep 2025 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758643003; x=1759247803; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RAZ4THQUhLp/jCSZc6k8pRe3JJ30LyWIBv7Rdm7k38s=;
        b=Brz8GCh1jvAR6tRGgodBpAXSQ1dAnUZT028DK1Xt6rPgYf2/WbDbqEZVCC9hYerpwq
         XFsbrz+RczTP8jYzEqkZbI5oOvXjN5vPbna9DwNLXkFe1Ip+dbwmC4UlHncnUVPX8Ybv
         nGlaCOSGPKisQxt0jIao7iREnNi+ZV3go1NyE3kUd6l7ut9J0KDQ/MkrQ5Pc3luHu5xO
         y9Gs8/2gjJL/99nPYMNAmDOoEB0ef1rZXqODVMfuFmAvNfUqadYgmwavJ98ECFjmwVje
         DMFMvcj/SYqsGSx0PQsahcxavnliD1fpTFEEFunOkStE4gdcgI5bmP9e+tyamQE4+mZ4
         1QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643003; x=1759247803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAZ4THQUhLp/jCSZc6k8pRe3JJ30LyWIBv7Rdm7k38s=;
        b=Rm/wMNE8x2F1VhyHj8eAAMkq5VvAwk/snHPPSdG721sYNU/bgy7WkbE1Z4HVfJRED3
         9FgJrx9J/zkkLcl4AJlJwgaIOPRjpo7ME0oimWkRtB+mVV2qNEccnQjRli066z9BJ3+7
         WbW/WSJG2hByAolu46BLX8y2GbIt7lp0E/4YIhjDAQ6vhst1CMviVCSYt/MyUvyH+GPU
         73sVLm4Bx7AMRu4Pz71Syq0IA1M8+uRvPKJaNg7awPIy82wdbm3GCg9R4jqRyr7/2eMs
         KNyr469ISTkBJwfxLiTnVe2BW8Tga7GgRjL3kSqFIkHzHIZkbtIiu5gpGcmfDpMtB/2d
         fZYg==
X-Forwarded-Encrypted: i=1; AJvYcCVXIEq2VphwV4zslkPhGhnXO6T45E1gJLS5iOmM/wNesyn/MYqgNB7Y9z64nP2agQdklZhxFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEJ0xHYt+l4bDNVIHoBFBv4zOC3p7SJa2FsU2nJCEQLr/B5r4B
	oHAmtiqTP3tHZNxoWVnJyeIM+sGFJeYzUJR1DXARYVcx1AbHyZtN2PIF
X-Gm-Gg: ASbGnctR0V1HwZDHf6nNPXs5rcpud4YS3368IPlL55RP8oXk6CpN4GO0p+sR/iWUzp9
	6NvjnAzTEpuw9ul93mNllmgJYtCJ5wCs3OWj+H03nM68OPkNhYoyS6M3bv4+pyInYotReNGku1n
	FT67zV+d1KaokQTfJVfAIUJtnwGErRaxcV51qurYlSgQgMuS9ikjRyYxFWqzut/bmx6AKSbd5xx
	9NyqL+A28xSi6szUIv6hA2CYyDRzwa9oiTAyBjzG7gVh8m/dEJ8akpvJwu5JjMQ7B2fqvBnemwC
	Fx0X/NBoUbZ4ykiRdFM+wdDuiWRrMhMc3t6OKMxk5vDk4iEMWFqnWIitsFsENhtiOwYsEkn24ec
	E0RUosnL/X3QwyWNinRsscOSDFNPfAPlCc5nQnrmuOEkKdsl9STYm0rMmXJIkvqBonHE/
X-Google-Smtp-Source: AGHT+IF0O7ehdqAB1QQAuoqY6m+j/Uj2ZkmlzqIVAVJm6bomKNVnwhf+M+9Mh3XvnYTFUDYTzupMzQ==
X-Received: by 2002:a05:600c:3b93:b0:468:7a5a:725 with SMTP id 5b1f17b1804b1-46e1d975205mr31719315e9.1.1758643002051;
        Tue, 23 Sep 2025 08:56:42 -0700 (PDT)
Received: from localhost (dhcp-91-156.inf.ed.ac.uk. [129.215.91.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac439sm284469705e9.5.2025.09.23.08.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:56:41 -0700 (PDT)
Date: Tue, 23 Sep 2025 16:56:40 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, damon@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	David Hildenbrand <david@redhat.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v6 05/15] mm/migrate_device: handle partially mapped folios
 during collection
Message-ID: <20250923155640.lbtvyi54ueyv2tjb@wrangler>
References: <20250916122128.2098535-1-balbirs@nvidia.com>
 <20250916122128.2098535-6-balbirs@nvidia.com>
 <3FE3F2B9-86F9-4EED-863A-093FE3959B1A@nvidia.com>
 <62fb7aca-cd30-4058-bfd1-d08f78d5c38d@nvidia.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62fb7aca-cd30-4058-bfd1-d08f78d5c38d@nvidia.com>

On Tue, Sep 23, 2025 at 01:44:20PM +1000, Balbir Singh wrote:
> On 9/23/25 12:23, Zi Yan wrote:
> > On 16 Sep 2025, at 8:21, Balbir Singh wrote:
> > 
> >> Extend migrate_vma_collect_pmd() to handle partially mapped large folios
> >> that require splitting before migration can proceed.
> >>
> >> During PTE walk in the collection phase, if a large folio is only
> >> partially mapped in the migration range, it must be split to ensure the
> >> folio is correctly migrated.
> >>
> >> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Zi Yan <ziy@nvidia.com>
> >> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> Cc: Rakie Kim <rakie.kim@sk.com>
> >> Cc: Byungchul Park <byungchul@sk.com>
> >> Cc: Gregory Price <gourry@gourry.net>
> >> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> >> Cc: Alistair Popple <apopple@nvidia.com>
> >> Cc: Oscar Salvador <osalvador@suse.de>
> >> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> >> Cc: Nico Pache <npache@redhat.com>
> >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> Cc: Dev Jain <dev.jain@arm.com>
> >> Cc: Barry Song <baohua@kernel.org>
> >> Cc: Lyude Paul <lyude@redhat.com>
> >> Cc: Danilo Krummrich <dakr@kernel.org>
> >> Cc: David Airlie <airlied@gmail.com>
> >> Cc: Simona Vetter <simona@ffwll.ch>
> >> Cc: Ralph Campbell <rcampbell@nvidia.com>
> >> Cc: Mika Penttilä <mpenttil@redhat.com>
> >> Cc: Matthew Brost <matthew.brost@intel.com>
> >> Cc: Francois Dugast <francois.dugast@intel.com>
> >> ---
> >>  mm/migrate_device.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 82 insertions(+)
> >>
> >> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> >> index abd9f6850db6..70c0601f70ea 100644
> >> --- a/mm/migrate_device.c
> >> +++ b/mm/migrate_device.c
> >> @@ -54,6 +54,53 @@ static int migrate_vma_collect_hole(unsigned long start,
> >>  	return 0;
> >>  }
> >>
> >> +/**
> >> + * migrate_vma_split_folio() - Helper function to split a THP folio
> >> + * @folio: the folio to split
> >> + * @fault_page: struct page associated with the fault if any
> >> + *
> >> + * Returns 0 on success
> >> + */
> >> +static int migrate_vma_split_folio(struct folio *folio,
> >> +				   struct page *fault_page)
> >> +{
> >> +	int ret;
> >> +	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
> >> +	struct folio *new_fault_folio = NULL;
> >> +
> >> +	if (folio != fault_folio) {
> >> +		folio_get(folio);
> >> +		folio_lock(folio);
> >> +	}
> >> +
> >> +	ret = split_folio(folio);
> >> +	if (ret) {
> >> +		if (folio != fault_folio) {
> >> +			folio_unlock(folio);
> >> +			folio_put(folio);
> >> +		}
> >> +		return ret;
> >> +	}
> >> +
> >> +	new_fault_folio = fault_page ? page_folio(fault_page) : NULL;
> >> +
> >> +	/*
> >> +	 * Ensure the lock is held on the correct
> >> +	 * folio after the split
> >> +	 */
> >> +	if (!new_fault_folio) {
> >> +		folio_unlock(folio);
> >> +		folio_put(folio);
> >> +	} else if (folio != new_fault_folio) {
> >> +		folio_get(new_fault_folio);
> >> +		folio_lock(new_fault_folio);
> >> +		folio_unlock(folio);
> >> +		folio_put(folio);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >>  				   unsigned long start,
> >>  				   unsigned long end,
> >> @@ -136,6 +183,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >>  			 * page table entry. Other special swap entries are not
> >>  			 * migratable, and we ignore regular swapped page.
> >>  			 */
> >> +			struct folio *folio;
> >> +
> >>  			entry = pte_to_swp_entry(pte);
> >>  			if (!is_device_private_entry(entry))
> >>  				goto next;
> >> @@ -147,6 +196,23 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >>  			    pgmap->owner != migrate->pgmap_owner)
> >>  				goto next;
> >>
> >> +			folio = page_folio(page);
> >> +			if (folio_test_large(folio)) {
> >> +				int ret;
> >> +
> >> +				pte_unmap_unlock(ptep, ptl);
> >> +				ret = migrate_vma_split_folio(folio,
> >> +							  migrate->fault_page);
> >> +
> >> +				if (ret) {
> >> +					ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> >> +					goto next;
> >> +				}
> >> +
> >> +				addr = start;
> >> +				goto again;
> >> +			}
> > 
> > This does not look right to me.
> > 
> > The folio here is device private, but migrate_vma_split_folio()
> > calls split_folio(), which cannot handle device private folios yet.
> > Your change to split_folio() is in Patch 10 and should be moved
> > before this patch.
> > 
> 
> Patch 10 is to split the folio in the middle of migration (when we have
> converted the entries to migration entries). This patch relies on the
> changes in patch 4. I agree the names are confusing, I'll reword the
> functions

Hi Balbir,

I am still reviewing the patches, but I think I agree with Zi here.

split_folio() will replace the PMD mappings of the huge folio with PTE
mappings, but will also split the folio into smaller folios. The former
is ok with this patch, but the latter is probably not correct if the folio
is a zone device folio. The driver needs to know about the change, as
usually the driver will have some sort of mapping between GPU physical
memory chunks and their corresponding zone device pages.

