Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56733CD
	for <damon@lists.linux.dev>; Fri, 12 Aug 2022 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660327289; x=1691863289;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=nqOcyiQ7gnXklQl1hkqdK2FgYHhXosu4jZoreon7co0=;
  b=Cu/vKuTWE6z6tjG5iQhtV815GNAj8QlS/BmEEtBxoglmecPqyCvnv9QW
   x/gUPmaRWW7ro/82LagCH4Y8AMl2nkJhzG6jqKiZNvrn07ZfvSqllVbbw
   qM8kG5PRohZ+/ibrUoBpn+v5bftVSc6n/1SnLEom801gYM5SeMxUoQMTT
   KJJBxRoRT7CK4cuu1gEon4sJKQoQryQDIiCBhU0RpRweO4ZN/LIUxQIxz
   VU6d8vIj0cz9nUJiSfKcK49rKAzBG6Eko/+VzTHAd4Mblg+6l2rgRcjqa
   z2cICsEOuLm5lOX9rMU0SIl+6tWpz/4bsPt/ytp76hVdULY0yuhHz8w3W
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="274708630"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="274708630"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 11:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="605992609"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2022 11:01:28 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 11:01:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 11:01:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 11:01:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 12 Aug 2022 11:01:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GI/VGWgP3f9zTuYBiIP8YUkSgpRdQnrIHtVjsXowfsZDYB0oW6VWVk8osdlwZ19Yxr5s371xH2nmPtPNNBlgYP32gCGCtlaCnohKTtPyxfe4hB/YBfdU1KmWVj8oWtLvOiv7oR90sAr6mZIoZqxxxGGUS/NjGoWbWX2ih5J/6EahXzi3noG/Ph3X3INGS2xzjqfIxwfsrtHeMuu1SrNgBUkEfsdEZ/KSTjp2gt+7wvKFn+xB/HZ2k6bDWQR2/ROgVRp2qWiGqz9hofoqfSnYGp/Xud4UD/ipJO3fYzffEqRzAYUE3dZNVk3ofvtoTgWHQPRYmSfc4YTmaGoJKMuvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh67gZ79UIh01qRVa8Q7LRSeZhktTCdotZFSLC+eSIo=;
 b=QwlPDrU6u/nIZXSpUSM5JRiY+ltEiRtYG/12vFBaPwDfy7vSzPJcwD0n3fWowHLVn16xXpS3h1xGxqy4+nqQjiq7xsi3mU1vDn1/W1vSpgu3oorSD1zkqPuBS+LCDPIWuilkbveNIdlwZ+wWOj58W3KH0IP/FlAsq+A9PmHc4BPmML3zy+m+NFVUeNgyUXXuAkkD06hZJo9gUxfmCoqXT9MmGcuH1g23RI/0PjjtwzE3EqEFxo/r8SIfMoq56GqL24/A3+lXkxCNNpZ0fr5h0JI5HDxyNAduTroDQoFve9um2OFm4RppFkIak3QelRQTnxKYD2ZL0PHxvF8aN8RsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3978.namprd11.prod.outlook.com (2603:10b6:5:19a::14)
 by BN6PR11MB1826.namprd11.prod.outlook.com (2603:10b6:404:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 18:01:25 +0000
Received: from DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::a186:a69e:dd1a:73ac]) by DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::a186:a69e:dd1a:73ac%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 18:01:25 +0000
From: "Pulavarty, Badari" <badari.pulavarty@intel.com>
To: "damon@lists.linux.dev" <damon@lists.linux.dev>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [PATCH] DAMON dbgfs_mk_context() error handling
Thread-Topic: [PATCH] DAMON dbgfs_mk_context() error handling
Thread-Index: AdiudYBAiI6eUiB2RbyOapwBra/TXw==
Date: Fri, 12 Aug 2022 18:01:25 +0000
Message-ID: <DM6PR11MB3978994F75A4104D714437379C679@DM6PR11MB3978.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ab85598-24b3-4a2c-d1e4-08da7c8cac40
x-ms-traffictypediagnostic: BN6PR11MB1826:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Azrus3b+ea5jgbWduMV2FgwpV59So1fy4S7KVj/jldvr2C8M/2hrlnlLiqlIm9rvG+A2SxhqEclQlv7BlRn1i7Cg3dZrsoNhxHxioRbOsP/JMxzf8b8uriYK/0j0IP9ZGf+uQSYZtm3bp4dTsNzYtNiqCMD8L5uUW+tLH6JzQAGJC3yui8fhSRJdE7eGZ8DC/UorR43K2xRWP+pD0KrThNm/SIcHQbuZ5XyTTkjGKAq5ex+AxKcTX1Pd8RK6mcb6/0oqp1lR+3eJ4uXf1BnePc9I6J5GYzLcu5rFAzt9Cci9sNqbs0VZyy2M5LgVuICuf17EP0UUj6dM0WyNUtH+YJqqPL8lF+GJwNBgxQf+j9mPUGey5axZBJzfYYzVaOxbMse4KEGfGdX6GraGzGm0nafohFtL4RfWgcublBqHNhFRAd0XMiCRvN3eY04FgC7TGytxoO8lYUMbygc4Z0n8fh2TRDpcFDdFIxe6ZtILNBE/xUNOOWQ+biNMP3/QFV3+cR/ueZPn0dOPARqKuS/8hRI0Lz2vuPbZF2Hn3nbmy45KcH3HM03xKPYclSRcEfuc+DEOk8SCOkF3MEiH5Aqglss9tFY7l7p74kgGrA9YBK639en9FUiI3DCIr5TMWIdvzYAw39kqbFjLw6uvfQzyjDgQBC533lBtMbh6Og5fC7Y2biA55XjA7uBQgFof2MFaPjBNbhrNYMeqsQ4FlDtIoBPdTaNd85/Zr6ZkbSMpR7dYjgyoXiWeQMZpwnbn0dh/oM2o9CWH7LQ59D90+wcniKYHkS2vbOz6U2KnJ9LEhPi/IgiklJLBdI4VERTDLz/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(136003)(366004)(39860400002)(26005)(38100700002)(82960400001)(6916009)(122000001)(4326008)(66476007)(66556008)(66946007)(8676002)(64756008)(76116006)(316002)(71200400001)(66446008)(38070700005)(9686003)(478600001)(8936002)(41300700001)(55016003)(52536014)(5660300002)(33656002)(2906002)(83380400001)(6506007)(7696005)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RTVvyfupwS3zSQdEM4MfihYlATDmDREf3QPoyBXa5vdim9U4ZDQxMSN3cRBR?=
 =?us-ascii?Q?9hzzHMfN5SfRj/2MUJAWqcUesoX4ZnzMbdkq4Oa6jh6tVh2MB+TeKOyh+Cei?=
 =?us-ascii?Q?6uRHyLdfSovJ4N7oG82792SWciv+2NI1san03LZvsKsblw9NdRwfA8ntah/h?=
 =?us-ascii?Q?DP8XP2SkjQTwIcX1zCYOyJrGca9HXkXRPK/9Rm7ZjERLLCnZKZzicIXjCKCL?=
 =?us-ascii?Q?c23bjkqOSQ0D8os0CaNerXXq81Gqs4VLnsbz6PIyR96eNsmf1vA+Ue/iTd9/?=
 =?us-ascii?Q?1cYwiHGNM8bGx+fo3IU05cvX5OZ2mecu7DyZcaW6OT0BhE+y0PhxlXF5e/V+?=
 =?us-ascii?Q?AdaI2eqkwIeq+XK62Xh7CAzsPwMuwCCTQyVL2OQ1ddmoznuQYAdATUoPUExf?=
 =?us-ascii?Q?mhzxaB14tyERfPM/eG2s07lJrYliplatAXAiZYHVDlGAEdnDkM+uG14GOMZN?=
 =?us-ascii?Q?9qoiXs9l6Rl0ph9WjKraU9Q8MK0rMJjVsfaW3Y7QlP2vSilu0+lSiu5x/R2y?=
 =?us-ascii?Q?/jWKMfRLpWZezGOYsRvKhdbbkDXQY/9YR0aR8V5bo9gCF2cxt1uMHYHAoI7Y?=
 =?us-ascii?Q?JsgipQuQdzGMEglbmNKSwUxuvBotDLmZK37NWHI0N09NiIcHRvfJtZt9hTqq?=
 =?us-ascii?Q?1fqz/NZjxp3ymlJT1Gh8Ib7kxyf2RVFu3nnegI5AkbKid7Yse2pQQobzzFC7?=
 =?us-ascii?Q?+ZfDkoSY/b9g9eEGUTI48E0/ik0WwvnoyGBT1HfQrFWo4R0m+N8mtfProf5m?=
 =?us-ascii?Q?YENJk3bVpsvEP/tp/ZRwUXR0rRF0G7MyFRR3zVw7sATh7+ybzKJyuJbmC+6T?=
 =?us-ascii?Q?XXDQAYIbENlZQLigkscODA5xkCfyx0J3mrDpFJBWVSyOuwwJcBZiM/7lONi3?=
 =?us-ascii?Q?jy+u9kfTFHIX0VvlIRr6AbeljKWSYw4GEzHcZ240qW53omKfULoV3MkdabvJ?=
 =?us-ascii?Q?wBnJCephKdECsvW5AqfxAeeeR7jx9qBPFla48j+5yMRpmEHrFBSfm3E12+q0?=
 =?us-ascii?Q?kedqJ0+vaFN3JGEFQiCe3fwNcNqdJDvf0bPrjzFK77cJ4vWZgmS4RtHTCiE1?=
 =?us-ascii?Q?ghuO1O1FJhA2udxB28AaFpcJ1mIhUPsVbJnVEjAEkUjthm4FDzAb3+qab0S/?=
 =?us-ascii?Q?/PF1kHniys9DkBeVox+J5VHwYieE3CMAEgpaAwaVx62bKCXJPBu3bHnkLkNj?=
 =?us-ascii?Q?3w4Yy5TCAxr+t8FOz6QAYxppMRAZztjh2bUEuua+veqlLaxzw9h2oQbPhS5q?=
 =?us-ascii?Q?VJDkV313s8wrXpV7Zpoqf//LZnIBWK++v+WcOKnCKX5TRpLz/qjsjdYPxBkI?=
 =?us-ascii?Q?PjiaBKX7uKbrugZ1wp2kJzeoLIKcL54edM+Lhdic6rpjgrQgm9TVqRpctHrq?=
 =?us-ascii?Q?yYJIEP5ajeNJM+sFNUuqFQ0b0MKrWH8wTRJjaad8XKo1UUdic46awKMZ+Kru?=
 =?us-ascii?Q?n8LIWgKiYMD/vbaSWgs6Ggh+ztiC4Xmi6MNvBW8wfJBS3qOPEBnW2ypDFwG1?=
 =?us-ascii?Q?7TmClXs2uHArNqt278RTLrF9nkrPY5WrCgQfNZ2WXkVrCGT1fwMW5GG0Ff7i?=
 =?us-ascii?Q?RFBiS6qF79KCUpH7A1v6sPKZMRmDmrRqnIlIwSgE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab85598-24b3-4a2c-d1e4-08da7c8cac40
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 18:01:25.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0D9pKyTDhzCVnT4D85aBSZnDzoUx783q+q+ZIa2r4Tb1DqD9Zvj8d5jUo/v414z4iBS0mOhfD1Lrln+wLRzUcUhtmeARdYW2sN1rLI27Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1826
X-OriginatorOrg: intel.com

damon dbgfs_mk_context() does not handle error from debugfs_create_dir() co=
rrectly.

For example, if one tries to create a context with existing name, debugfs_c=
reate_dir() fails
with -EEXIST, but dbgfs_mk_context() assumes the call is successful and add=
s another entry - which
will cause failures when try to enable the monitor.

Test case:

echo "off" >  /sys/kernel/debug/damon/monitor_on
echo "abc" > /sys/kernel/debug/damon/mk_context
echo "abc" > /sys/kernel/debug/damon/mk_context
echo <pid> > /sys/kernel/debug/damon/target_ids
echo "on" > /sys/kernel/debug/damon/monitor_on  <<< fails to enable monitor

Signed-off-by: Badari Pulavarty badari.pulavarty@intel.com
---
--- orig/mm/damon/dbgfs.c       2022-08-05 13:35:54.416831666 -0400
+++ new/mm/damon/dbgfs.c        2022-08-05 13:44:25.121849930 -0400
@@ -721,6 +721,9 @@ static int dbgfs_mk_context(char *name)
                return -ENOENT;

        new_dir =3D debugfs_create_dir(name, root);
+       if (IS_ERR(new_dir)) {
+               return PTR_ERR(new_dir);
+       }
        dbgfs_dirs[dbgfs_nr_ctxs] =3D new_dir;

        new_ctx =3D dbgfs_new_ctx();
