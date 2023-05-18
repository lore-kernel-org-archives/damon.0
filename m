Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1917AB8
	for <damon@lists.linux.dev>; Thu, 18 May 2023 12:08:19 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6235aac00edso17321126d6.1
        for <damon@lists.linux.dev>; Thu, 18 May 2023 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1684411698; x=1687003698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlSicM60M4dOjJmxLJdTJyVXpqMpmrkkdEYFA1QkhPE=;
        b=jXhbGwJYk+ucvKbOBXk9WSgeJcL3XBMB2oa3nevNUqtzUVeZ8g0iTX2cviMuUPVK95
         BQihpwuuJEweV2yyrM4IL8PBMZvQBL0c3xq2CZieXROU8/pAIGkzt7Du9V84OKSqWVa2
         Fmaup6LyQllNdQhTLl6BDsdSt4uKUWNmqAZYSGgsy0Ig9WrRRVwSYBI2WdO+rbDcX6dP
         ZHDkZsrwBLEfGkdL77B/DNN8d0hrQ0AB06V2qRbzdl6gVkrx1QZ9lhG4j5FVzlai9Vdo
         CwWrJuIH+r4avhI/j4oqn22bBWtZGlopVE5yl+AqPepXDxbBFyz4orMZqXgaamG+erIA
         Wopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411698; x=1687003698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlSicM60M4dOjJmxLJdTJyVXpqMpmrkkdEYFA1QkhPE=;
        b=CnHW8hcljRelrf1pxITwIBqDSNjdvDUt5HUmPUonAp0IBI7AZN3Ct5jUyVrTJLiZJg
         nQLWmY9AAsfDHS2RjjPmCL54TXdxU83D3sq26O2evNomkMQO5VEF8Ww4CBjCpkNVtEfL
         PaPLdmXh0TmpqQQX6z6CsuVLaK2ll0JspNK6qBS1LNTTPuSwkP4QbhLhiynM9ddZU04r
         8ZMA0SnHfpyqF8nKTW6O9jLuJ5kXj3DzZT2hIIJtT7aRQ+XSjNcUvgtmq2WLypc5wKr4
         6ZaY/qoisAjXpZBeF3RQu8K4Ezo+ZxUuIncpFmuvpXptpEG7BPFLvQJXyacBe30x0Sut
         arcw==
X-Gm-Message-State: AC+VfDw+8HZp3zB+ED+EYd9Q55l2GNmgpHUvKBnFsroxVrtpRFvZUHnq
	AHnN94neWZvWX64ozLzbtsEmkw==
X-Google-Smtp-Source: ACHHUZ5mv2MO2EtoWMDVdFMmwyMdsVIazSj3Ntt0VpmSdM56xlcT74f7C5fr+MIKywX+lt8aPIbl3w==
X-Received: by 2002:a05:6214:5296:b0:5c1:fa35:fe6 with SMTP id kj22-20020a056214529600b005c1fa350fe6mr5510734qvb.24.1684411698376;
        Thu, 18 May 2023 05:08:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id jy17-20020a0562142b5100b0061b2a2f949bsm469563qvb.61.2023.05.18.05.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:08:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pzcQa-0055S6-P5;
	Thu, 18 May 2023 09:08:16 -0300
Date: Thu, 18 May 2023 09:08:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	damon@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 5/5] mm: ptep_deref() conversion
Message-ID: <ZGYVMMumjG1p84c8@ziepe.ca>
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-6-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518110727.2106156-6-ryan.roberts@arm.com>

On Thu, May 18, 2023 at 12:07:27PM +0100, Ryan Roberts wrote:

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 3d4dd9420c30..5680542f744f 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -514,6 +514,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  			    bool write_fault)
>  {
>  	pte_t *ptep;
> +	pte_t pte;
>  	spinlock_t *ptl;
>  	int ret;
>  
> @@ -536,10 +537,12 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  			return ret;
>  	}
>  
> -	if (write_fault && !pte_write(*ptep))
> +	pte = ptep_deref(ptep);
> +
> +	if (write_fault && !pte_write(pte))
>  		ret = -EFAULT;
>  	else
> -		*pfn = pte_pfn(*ptep);
> +		*pfn = pte_pfn(pte);
>  
>  	pte_unmap_unlock(ptep, ptl);
>  	return ret;

This hunk looks Ok

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
